#!/bin/bash

# WeirdBrains Feature Branch Setup for Task Master Integration
# This script moves Task Master setup from production branches to feature branches

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

# Repository configuration
declare -A REPOS=(
    ["mandible_app"]="master"
    ["sso_backend"]="production"
    ["backend"]="main"
    ["accounts"]="main"
    ["project-nexus"]="main"
)

FEATURE_BRANCH="feature/task-master-integration"
BASE_DIR="/home/zack-mohorn/Desktop/Code/WeirdBrains"

# Function to handle repository branch setup
setup_repo_branches() {
    local repo_name=$1
    local current_branch=$2
    local repo_path="${BASE_DIR}/${repo_name}"
    
    print_header "Setting up ${repo_name}"
    
    if [ ! -d "$repo_path" ]; then
        print_error "Repository ${repo_name} not found at ${repo_path}"
        return 1
    fi
    
    cd "$repo_path"
    
    # Check current branch
    local actual_branch=$(git branch --show-current)
    print_info "Current branch: ${actual_branch}"
    
    # Stash any uncommitted changes
    if [ -n "$(git status --porcelain)" ]; then
        print_info "Stashing uncommitted changes..."
        git stash push -m "Task Master setup - $(date)"
    fi
    
    # Switch to main branch (or appropriate base)
    local base_branch="main"
    if [ "$repo_name" = "mandible_app" ]; then
        base_branch="main"
    fi
    
    # Fetch latest changes
    print_info "Fetching latest changes..."
    git fetch origin
    
    # Switch to base branch
    print_info "Switching to ${base_branch}..."
    if git show-ref --verify --quiet refs/heads/${base_branch}; then
        git checkout ${base_branch}
    elif git show-ref --verify --quiet refs/remotes/origin/${base_branch}; then
        git checkout -b ${base_branch} origin/${base_branch}
    else
        print_warning "Base branch ${base_branch} not found, using current branch"
    fi
    
    # Pull latest changes
    git pull origin ${base_branch} || print_warning "Could not pull latest changes"
    
    # Create feature branch
    print_info "Creating feature branch: ${FEATURE_BRANCH}"
    if git show-ref --verify --quiet refs/heads/${FEATURE_BRANCH}; then
        print_warning "Feature branch already exists, switching to it"
        git checkout ${FEATURE_BRANCH}
    else
        git checkout -b ${FEATURE_BRANCH}
    fi
    
    # If we had Task Master setup on production/master branch, we need to recreate it
    if [ "$current_branch" != "$base_branch" ] && [ "$current_branch" != "${FEATURE_BRANCH}" ]; then
        print_info "Recreating Task Master setup from ${current_branch}..."
        
        # Checkout the .taskmaster directory from the original branch
        git checkout ${current_branch} -- .taskmaster/ 2>/dev/null || print_warning "No .taskmaster directory found on ${current_branch}"
        
        # Apply any stashed changes
        git stash pop 2>/dev/null || print_info "No stashed changes to apply"
        
        # Add Task Master files
        if [ -d ".taskmaster" ]; then
            git add .taskmaster/
            print_success "Task Master configuration added to feature branch"
        fi
    fi
    
    print_success "Repository ${repo_name} setup complete"
    echo ""
}

# Function to create GitHub integration
setup_github_integration() {
    print_header "Setting up GitHub Integration"
    
    # Create GitHub Actions workflow for each repository
    for repo_name in "${!REPOS[@]}"; do
        local repo_path="${BASE_DIR}/${repo_name}"
        cd "$repo_path"
        
        # Create .github/workflows directory
        mkdir -p .github/workflows
        
        # Create Task Master sync workflow
        cat > .github/workflows/taskmaster-sync.yml << EOF
name: TaskMaster GitHub Integration

on:
  issues:
    types: [opened, closed, edited, labeled, unlabeled]
  pull_request:
    types: [opened, closed, merged, ready_for_review]
  workflow_dispatch:

jobs:
  sync-taskmaster:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          
      - name: Install Task Master AI
        run: npm install -g task-master-ai
        
      - name: Sync GitHub events with Task Master
        env:
          GITHUB_TOKEN: \${{ secrets.GITHUB_TOKEN }}
          REPO_NAME: ${repo_name}
        run: |
          echo "Syncing GitHub events for ${repo_name}"
          echo "Event: \${{ github.event_name }}"
          echo "Action: \${{ github.event.action }}"
          
          # Future: Add actual sync logic here
          # task-master sync-github --event="\${{ github.event_name }}" --action="\${{ github.event.action }}"
          
      - name: Update cross-repository coordination
        if: github.repository == 'WeirdBrains/project-nexus'
        run: |
          echo "Updating cross-repository coordination in project-nexus"
          # Future: Trigger coordination updates
EOF

        git add .github/workflows/taskmaster-sync.yml
        print_success "GitHub Actions workflow created for ${repo_name}"
    done
}

# Function to create branch-aware task management
setup_branch_integration() {
    print_header "Setting up Branch-Aware Task Management"
    
    cd "${BASE_DIR}/project-nexus"
    
    # Create branch coordination configuration
    mkdir -p coordination/branches
    
    cat > coordination/branches/branch-task-mapping.json << EOF
{
  "branchTaskMapping": {
    "version": "1.0.0",
    "lastUpdated": "$(date -Iseconds)",
    "repositories": {
      "mandible_app": {
        "currentBranch": "${FEATURE_BRANCH}",
        "taskBranches": {
          "${FEATURE_BRANCH}": {
            "tasks": ["task-master-integration", "ui-improvements"],
            "baseBranch": "main",
            "status": "active"
          }
        }
      },
      "sso_backend": {
        "currentBranch": "${FEATURE_BRANCH}",
        "taskBranches": {
          "${FEATURE_BRANCH}": {
            "tasks": ["auth-api-improvements", "task-master-integration"],
            "baseBranch": "main",
            "status": "active"
          }
        }
      },
      "backend": {
        "currentBranch": "${FEATURE_BRANCH}",
        "taskBranches": {
          "${FEATURE_BRANCH}": {
            "tasks": ["api-enhancements", "task-master-integration"],
            "baseBranch": "main",
            "status": "active"
          }
        }
      }
    },
    "branchWorkflows": {
      "feature-branch-creation": {
        "steps": [
          "Create feature branch from main",
          "Initialize Task Master if needed",
          "Create branch-specific tasks",
          "Link to cross-repository coordination"
        ]
      },
      "task-completion": {
        "steps": [
          "Mark task as complete",
          "Update branch status",
          "Check cross-repository dependencies",
          "Trigger PR creation if ready"
        ]
      }
    }
  }
}
EOF

    # Create branch management script
    cat > coordination/branches/manage-branches.sh << 'EOF'
#!/bin/bash

# Branch-aware task management for WeirdBrains

FEATURE_BRANCH="feature/task-master-integration"
BASE_DIR="/home/zack-mohorn/Desktop/Code/WeirdBrains"

# Function to create task-specific feature branch
create_task_branch() {
    local repo_name=$1
    local task_id=$2
    local branch_name="feature/task-${task_id}"
    
    cd "${BASE_DIR}/${repo_name}"
    
    # Create branch from main
    git checkout main
    git pull origin main
    git checkout -b "$branch_name"
    
    echo "Created branch $branch_name for task $task_id in $repo_name"
}

# Function to link task to branch
link_task_to_branch() {
    local repo_name=$1
    local task_id=$2
    local branch_name=$3
    
    cd "${BASE_DIR}/${repo_name}"
    
    # Update task with branch information
    task-master update-task --id="$task_id" --prompt="Working on branch: $branch_name"
    
    echo "Linked task $task_id to branch $branch_name"
}

# Function to check cross-repository branch status
check_cross_repo_branches() {
    echo "Cross-Repository Branch Status:"
    echo "================================"
    
    for repo in mandible_app backend sso_backend accounts project-nexus; do
        if [ -d "${BASE_DIR}/${repo}" ]; then
            cd "${BASE_DIR}/${repo}"
            local current_branch=$(git branch --show-current)
            local status=$(git status --porcelain | wc -l)
            echo "$repo: $current_branch ($status uncommitted changes)"
        fi
    done
}

# Main execution based on command
case "$1" in
    "create")
        create_task_branch "$2" "$3"
        ;;
    "link")
        link_task_to_branch "$2" "$3" "$4"
        ;;
    "status")
        check_cross_repo_branches
        ;;
    *)
        echo "Usage: $0 {create|link|status}"
        echo "  create <repo> <task_id>           - Create feature branch for task"
        echo "  link <repo> <task_id> <branch>    - Link task to branch"
        echo "  status                            - Show cross-repo branch status"
        ;;
esac
EOF

    chmod +x coordination/branches/manage-branches.sh
    
    git add coordination/branches/
    print_success "Branch integration setup complete"
}

# Main execution
main() {
    print_header "WeirdBrains Feature Branch Setup for Task Master Integration"
    
    # Setup feature branches for each repository
    for repo_name in "${!REPOS[@]}"; do
        setup_repo_branches "$repo_name" "${REPOS[$repo_name]}"
    done
    
    # Setup GitHub integration
    setup_github_integration
    
    # Setup branch-aware task management
    setup_branch_integration
    
    print_header "Setup Complete!"
    print_success "All repositories now have feature branches with Task Master integration"
    print_info "Next steps:"
    echo "  1. Review and commit changes in each repository"
    echo "  2. Push feature branches to GitHub"
    echo "  3. Create pull requests when ready"
    echo "  4. Use coordination/branches/manage-branches.sh for branch management"
    
    print_info "Branch status check:"
    cd "${BASE_DIR}/project-nexus"
    ./coordination/branches/manage-branches.sh status
}

# Run main function
main "$@"
