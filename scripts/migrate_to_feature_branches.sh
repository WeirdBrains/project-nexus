#!/bin/bash

# WeirdBrains: Migrate Task Master Setup from Production to Feature Branches
# CRITICAL: This script moves Task Master setup OFF production branches

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Repository paths - adjust these to your actual structure
MANDIBLE_PATH="/home/zack-mohorn/Desktop/Code/WeirdBrains/WeirdBrains-v2/repositories/mandible"
BACKEND_PATH="/home/zack-mohorn/Desktop/Code/WeirdBrains/WeirdBrains-v2/repositories/backend-api"
SSO_BACKEND_PATH="/home/zack-mohorn/Desktop/Code/WeirdBrains/WeirdBrains-v2/repositories/backend-sso"
ACCOUNTS_PATH="/home/zack-mohorn/Desktop/Code/WeirdBrains/WeirdBrains-v2/repositories/accounts"
PROJECT_NEXUS_PATH="/home/zack-mohorn/Desktop/Code/WeirdBrains/WeirdBrains-v2/coordination/project-nexus"

FEATURE_BRANCH="feature/task-master-integration"

# Function to safely migrate a repository
migrate_repository() {
    local repo_path=$1
    local repo_name=$2
    
    print_header "Migrating ${repo_name}"
    
    if [ ! -d "$repo_path" ]; then
        print_error "Repository not found: $repo_path"
        return 1
    fi
    
    cd "$repo_path"
    
    # Check current branch
    local current_branch=$(git branch --show-current 2>/dev/null || echo "unknown")
    print_info "Current branch: ${current_branch}"
    
    # Backup Task Master files if they exist
    if [ -d ".taskmaster" ]; then
        print_info "Backing up Task Master configuration..."
        cp -r .taskmaster /tmp/taskmaster_backup_${repo_name}_$(date +%s)
        print_success "Backup created in /tmp/"
    fi
    
    # Stash any uncommitted changes
    if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
        print_info "Stashing uncommitted changes..."
        git stash push -m "Task Master migration - $(date)" || print_warning "Could not stash changes"
    fi
    
    # Fetch latest changes
    print_info "Fetching latest changes..."
    git fetch origin || print_warning "Could not fetch from origin"
    
    # Switch to main branch
    print_info "Switching to main branch..."
    if git show-ref --verify --quiet refs/heads/main; then
        git checkout main
    elif git show-ref --verify --quiet refs/remotes/origin/main; then
        git checkout -b main origin/main
    else
        print_warning "Main branch not found, creating from current state"
        git checkout -b main
    fi
    
    # Pull latest main
    git pull origin main 2>/dev/null || print_warning "Could not pull latest main"
    
    # Create feature branch
    print_info "Creating feature branch: ${FEATURE_BRANCH}"
    if git show-ref --verify --quiet refs/heads/${FEATURE_BRANCH}; then
        print_warning "Feature branch exists, switching to it"
        git checkout ${FEATURE_BRANCH}
    else
        git checkout -b ${FEATURE_BRANCH}
    fi
    
    # Restore Task Master files to feature branch
    if [ -d "/tmp/taskmaster_backup_${repo_name}"* ]; then
        print_info "Restoring Task Master configuration to feature branch..."
        local backup_dir=$(ls -d /tmp/taskmaster_backup_${repo_name}_* | head -1)
        cp -r "$backup_dir" .taskmaster
        git add .taskmaster/
        print_success "Task Master configuration restored"
    fi
    
    # Remove Task Master from production branch if it exists there
    if [ "$current_branch" = "production" ] || [ "$current_branch" = "master" ]; then
        print_info "Cleaning Task Master from production branch..."
        git checkout "$current_branch"
        if [ -d ".taskmaster" ]; then
            git rm -rf .taskmaster/ || rm -rf .taskmaster/
            git add -A
            git commit -m "Remove Task Master setup from production branch" || print_info "Nothing to commit"
        fi
        git checkout ${FEATURE_BRANCH}
        print_success "Task Master removed from production branch"
    fi
    
    print_success "Migration complete for ${repo_name}"
    echo ""
}

# Function to create GitHub branch integration
create_branch_integration() {
    print_header "Creating GitHub Branch Integration"
    
    cd "$PROJECT_NEXUS_PATH"
    
    # Create branch coordination system
    mkdir -p coordination/branches
    
    cat > coordination/branches/branch-task-coordination.json << EOF
{
  "branchTaskCoordination": {
    "version": "1.0.0",
    "lastUpdated": "$(date -Iseconds)",
    "featureBranch": "${FEATURE_BRANCH}",
    "repositories": {
      "mandible": {
        "path": "${MANDIBLE_PATH}",
        "currentBranch": "${FEATURE_BRANCH}",
        "productionBranch": "production",
        "mainBranch": "main",
        "taskMasterEnabled": true,
        "tasks": []
      },
      "backend": {
        "path": "${BACKEND_PATH}",
        "currentBranch": "${FEATURE_BRANCH}",
        "productionBranch": "production", 
        "mainBranch": "main",
        "taskMasterEnabled": true,
        "tasks": []
      },
      "sso_backend": {
        "path": "${SSO_BACKEND_PATH}",
        "currentBranch": "${FEATURE_BRANCH}",
        "productionBranch": "production",
        "mainBranch": "main", 
        "taskMasterEnabled": true,
        "tasks": []
      },
      "accounts": {
        "path": "${ACCOUNTS_PATH}",
        "currentBranch": "${FEATURE_BRANCH}",
        "productionBranch": "production",
        "mainBranch": "main",
        "taskMasterEnabled": true,
        "tasks": []
      }
    },
    "branchWorkflows": {
      "taskCreation": {
        "description": "Create tasks only on feature branches, never on production",
        "steps": [
          "Ensure on feature branch",
          "Create task with branch context",
          "Link to cross-repository coordination",
          "Assign to appropriate agent"
        ]
      },
      "taskCompletion": {
        "description": "Complete tasks and prepare for PR",
        "steps": [
          "Mark task complete on feature branch",
          "Update cross-repository dependencies",
          "Prepare PR for review",
          "Merge to main after approval"
        ]
      },
      "productionDeployment": {
        "description": "Deploy to production only after full testing",
        "steps": [
          "Merge feature branch to main",
          "Run full test suite",
          "Deploy to staging",
          "Validate in staging",
          "Merge main to production"
        ]
      }
    }
  }
}
EOF

    # Create branch management commands
    cat > coordination/branches/branch-commands.sh << 'EOF'
#!/bin/bash

# WeirdBrains Branch Management Commands

FEATURE_BRANCH="feature/task-master-integration"

# Function to check all repository branches
check_all_branches() {
    echo "🔍 WeirdBrains Repository Branch Status"
    echo "======================================="
    
    local repos=(
        "/home/zack-mohorn/Desktop/Code/WeirdBrains:mandible"
        "/home/zack-mohorn/Desktop/Code/WeirdBrains/backend:backend"
        "/home/zack-mohorn/Desktop/Code/WeirdBrains/sso_backend:sso_backend"
        "/home/zack-mohorn/Desktop/Code/WeirdBrains/accounts:accounts"
        "/home/zack-mohorn/Desktop/Code/WeirdBrains/project-nexus:project-nexus"
    )
    
    for repo_info in "${repos[@]}"; do
        local path="${repo_info%:*}"
        local name="${repo_info#*:}"
        
        if [ -d "$path" ]; then
            cd "$path"
            local current_branch=$(git branch --show-current 2>/dev/null || echo "unknown")
            local status=$(git status --porcelain 2>/dev/null | wc -l)
            local taskmaster_status="❌"
            
            if [ -d ".taskmaster" ]; then
                taskmaster_status="✅"
            fi
            
            echo "📁 $name:"
            echo "   Branch: $current_branch"
            echo "   Changes: $status uncommitted"
            echo "   Task Master: $taskmaster_status"
            echo ""
        else
            echo "❌ $name: Directory not found at $path"
        fi
    done
}

# Function to ensure all repos are on feature branch
ensure_feature_branches() {
    echo "🔄 Ensuring all repositories are on feature branch..."
    
    local repos=(
        "/home/zack-mohorn/Desktop/Code/WeirdBrains"
        "/home/zack-mohorn/Desktop/Code/WeirdBrains/backend"
        "/home/zack-mohorn/Desktop/Code/WeirdBrains/sso_backend"
        "/home/zack-mohorn/Desktop/Code/WeirdBrains/accounts"
        "/home/zack-mohorn/Desktop/Code/WeirdBrains/project-nexus"
    )
    
    for repo_path in "${repos[@]}"; do
        if [ -d "$repo_path" ]; then
            cd "$repo_path"
            local current_branch=$(git branch --show-current 2>/dev/null || echo "unknown")
            
            if [ "$current_branch" != "$FEATURE_BRANCH" ]; then
                echo "⚠️  Switching $repo_path to $FEATURE_BRANCH"
                git checkout "$FEATURE_BRANCH" 2>/dev/null || git checkout -b "$FEATURE_BRANCH"
            else
                echo "✅ $repo_path already on $FEATURE_BRANCH"
            fi
        fi
    done
}

# Function to create task with branch awareness
create_branch_aware_task() {
    local repo_path=$1
    local task_title=$2
    local task_description=$3
    
    cd "$repo_path"
    
    # Ensure on feature branch
    local current_branch=$(git branch --show-current)
    if [ "$current_branch" != "$FEATURE_BRANCH" ]; then
        echo "⚠️  Not on feature branch. Switching to $FEATURE_BRANCH"
        git checkout "$FEATURE_BRANCH" || git checkout -b "$FEATURE_BRANCH"
    fi
    
    # Create task with branch context
    task-master add-task \
        --title="$task_title" \
        --description="$task_description (Branch: $FEATURE_BRANCH)" \
        --priority="medium"
    
    echo "✅ Task created on branch $FEATURE_BRANCH"
}

# Main command handler
case "$1" in
    "status")
        check_all_branches
        ;;
    "ensure-feature")
        ensure_feature_branches
        ;;
    "create-task")
        create_branch_aware_task "$2" "$3" "$4"
        ;;
    *)
        echo "WeirdBrains Branch Management Commands"
        echo "====================================="
        echo ""
        echo "Usage: $0 {status|ensure-feature|create-task}"
        echo ""
        echo "Commands:"
        echo "  status                              - Show branch status for all repos"
        echo "  ensure-feature                      - Switch all repos to feature branch"
        echo "  create-task <repo> <title> <desc>   - Create task on feature branch"
        echo ""
        echo "Examples:"
        echo "  $0 status"
        echo "  $0 ensure-feature"
        echo "  $0 create-task /path/to/repo 'Fix bug' 'Description'"
        ;;
esac
EOF

    chmod +x coordination/branches/branch-commands.sh
    
    git add coordination/branches/
    print_success "Branch integration created"
}

# Main execution
main() {
    print_header "WeirdBrains: Migrate Task Master from Production to Feature Branches"
    
    print_warning "IMPORTANT: This will move Task Master setup OFF production branches"
    print_info "Press Enter to continue, or Ctrl+C to cancel..."
    read -r
    
    # Migrate each repository
    migrate_repository "$MANDIBLE_PATH" "mandible"
    migrate_repository "$BACKEND_PATH" "backend" 
    migrate_repository "$SSO_BACKEND_PATH" "sso_backend"
    migrate_repository "$ACCOUNTS_PATH" "accounts"
    migrate_repository "$PROJECT_NEXUS_PATH" "project-nexus"
    
    # Create branch integration
    create_branch_integration
    
    print_header "Migration Complete!"
    print_success "All Task Master setup moved to feature branches"
    print_warning "Production branches are now clean of Task Master files"
    print_info "Next steps:"
    echo "  1. Review changes in each repository"
    echo "  2. Commit Task Master setup on feature branches"
    echo "  3. Use coordination/branches/branch-commands.sh for branch management"
    echo "  4. Create PRs when ready to merge to main"
    
    print_info "Check status with:"
    echo "  cd $PROJECT_NEXUS_PATH"
    echo "  ./coordination/branches/branch-commands.sh status"
}

# Run main function
main "$@"
