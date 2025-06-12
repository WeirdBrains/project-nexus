#!/bin/bash

# WeirdBrains Cross-Repository Task Master Setup Script
# This script initializes Task Master AI across all core WeirdBrains repositories
# and sets up cross-repository coordination

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
WEIRDBRAINS_ORG="WeirdBrains"
BASE_DIR="${HOME}/Desktop/Code/WeirdBrains/WeirdBrains-v2"
MANDIBLE_CONFIG_SOURCE="${BASE_DIR}/repositories/mandible/.taskmaster/config.json"

# Core repositories in priority order
CORE_REPOS=(
    "project-nexus"
    "backend" 
    "sso_backend"
    "accounts"
    "infrastructure"
    "onesignal-mcp"
    "moire"
    "sso_widgets"
)

# Supporting repositories
SUPPORTING_REPOS=(
    "soma"
    "skeli"
    "admin-web"
    "website"
)

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

# Check prerequisites
check_prerequisites() {
    print_header "Checking Prerequisites"
    
    # Check if git is installed
    if ! command -v git &> /dev/null; then
        print_error "Git is not installed. Please install git first."
        exit 1
    fi
    
    # Check if npm is installed (for task-master-ai)
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed. Please install Node.js and npm first."
        exit 1
    fi
    
    # Check if task-master is available
    if ! command -v task-master &> /dev/null; then
        print_info "Installing task-master-ai globally..."
        npm install -g task-master-ai
    fi
    
    # Check if mandible config exists
    if [ ! -f "$MANDIBLE_CONFIG_SOURCE" ]; then
        print_error "Mandible Task Master config not found at: $MANDIBLE_CONFIG_SOURCE"
        print_info "Please ensure mandible_app has Task Master initialized first."
        exit 1
    fi
    
    print_success "All prerequisites met"
}

# Clone repository if it doesn't exist
clone_repo_if_needed() {
    local repo_name=$1
    local repo_path="${BASE_DIR}/${repo_name}"
    
    if [ ! -d "$repo_path" ]; then
        print_info "Cloning ${repo_name}..."
        cd "$BASE_DIR"
        git clone "https://github.com/${WEIRDBRAINS_ORG}/${repo_name}.git"
        if [ $? -eq 0 ]; then
            print_success "Cloned ${repo_name}"
        else
            print_error "Failed to clone ${repo_name}"
            return 1
        fi
    else
        print_info "${repo_name} already exists locally"
    fi
    
    return 0
}

# Initialize Task Master in a repository
init_taskmaster_in_repo() {
    local repo_name=$1
    local repo_path="${BASE_DIR}/${repo_name}"
    
    print_info "Initializing Task Master in ${repo_name}..."
    
    cd "$repo_path"
    
    # Check if already initialized
    if [ -d ".taskmaster" ]; then
        print_warning "Task Master already initialized in ${repo_name}"
        return 0
    fi
    
    # Initialize Task Master
    task-master init --name="$repo_name" --yes
    
    if [ $? -eq 0 ]; then
        print_success "Task Master initialized in ${repo_name}"
        
        # Copy configuration from mandible
        if [ -f "$MANDIBLE_CONFIG_SOURCE" ]; then
            cp "$MANDIBLE_CONFIG_SOURCE" ".taskmaster/config.json"
            print_success "Copied configuration from mandible to ${repo_name}"
        fi
        
        return 0
    else
        print_error "Failed to initialize Task Master in ${repo_name}"
        return 1
    fi
}

# Set up project-nexus as master coordinator
setup_project_nexus() {
    print_header "Setting up project-nexus as Master Coordinator"
    
    local nexus_path="${BASE_DIR}/project-nexus"
    
    if [ ! -d "$nexus_path" ]; then
        print_error "project-nexus not found. Please ensure it's cloned first."
        return 1
    fi
    
    cd "$nexus_path"
    
    # Create coordination directory structure
    mkdir -p coordination documentation scripts .taskmaster/cross-repo
    
    # Create coordination files
    cat > coordination/repository-dependencies.md << 'EOF'
# Repository Dependencies

## Core Dependencies
- mandible → backend, sso_backend, accounts
- backend → sso_backend, infrastructure
- accounts → sso_backend, sso_widgets
- sso_backend → infrastructure

## Integration Points
- All frontends → backend (API calls)
- All services → sso_backend (authentication)
- All deployments → infrastructure (hosting)
EOF

    cat > coordination/ai-agent-assignments.md << 'EOF'
# AI Agent Assignment Matrix

## Factory.ai Backend Agent
- Repositories: backend, sso_backend, infrastructure
- Technologies: Dart Frog, PostgreSQL, Kubernetes
- Task Types: API development, database design, infrastructure

## Factory.ai Frontend Agent  
- Repositories: mandible, accounts, sso_widgets
- Technologies: Flutter, Riverpod, UI design
- Task Types: UI development, state management, UX

## Augment Agent
- Repositories: All repositories
- Technologies: Code analysis, optimization, debugging
- Task Types: Code review, performance optimization, bug fixing
EOF

    cat > scripts/sync-repositories.js << 'EOF'
#!/usr/bin/env node
// Cross-repository synchronization script
console.log('Cross-repository sync script - placeholder for implementation');
EOF

    chmod +x scripts/sync-repositories.js
    
    print_success "project-nexus coordination structure created"
}

# Create cross-repository task template
create_cross_repo_task_template() {
    local nexus_path="${BASE_DIR}/project-nexus"
    
    cat > "${nexus_path}/.taskmaster/cross-repo/task-template.json" << 'EOF'
{
  "crossRepoTaskTemplate": {
    "id": "template-id",
    "title": "Cross-Repository Task Title",
    "description": "Description of the cross-repository task",
    "masterRepo": "project-nexus",
    "repositories": {
      "repo-name": {
        "taskIds": ["task-1", "task-2"],
        "status": "pending",
        "dependencies": [],
        "assignedAgent": "agent-name",
        "blockers": []
      }
    },
    "overallStatus": "pending",
    "criticalPath": [],
    "priority": "medium",
    "estimatedDuration": "1 week",
    "created": "2025-01-01T00:00:00Z",
    "updated": "2025-01-01T00:00:00Z"
  }
}
EOF

    print_success "Cross-repository task template created"
}

# Generate repository status report
generate_status_report() {
    print_header "Generating Repository Status Report"
    
    local report_file="${BASE_DIR}/taskmaster_setup_report.md"
    
    cat > "$report_file" << EOF
# WeirdBrains Task Master Setup Report
Generated: $(date)

## Repository Status

### Core Repositories
EOF

    for repo in "${CORE_REPOS[@]}"; do
        local repo_path="${BASE_DIR}/${repo}"
        if [ -d "$repo_path" ]; then
            if [ -d "$repo_path/.taskmaster" ]; then
                echo "- ✅ **${repo}**: Task Master initialized" >> "$report_file"
            else
                echo "- ❌ **${repo}**: Task Master NOT initialized" >> "$report_file"
            fi
        else
            echo "- ⚠️  **${repo}**: Repository not cloned locally" >> "$report_file"
        fi
    done
    
    cat >> "$report_file" << EOF

### Supporting Repositories
EOF

    for repo in "${SUPPORTING_REPOS[@]}"; do
        local repo_path="${BASE_DIR}/${repo}"
        if [ -d "$repo_path" ]; then
            if [ -d "$repo_path/.taskmaster" ]; then
                echo "- ✅ **${repo}**: Task Master initialized" >> "$report_file"
            else
                echo "- ❌ **${repo}**: Task Master NOT initialized" >> "$report_file"
            fi
        else
            echo "- ⚠️  **${repo}**: Repository not cloned locally" >> "$report_file"
        fi
    done
    
    cat >> "$report_file" << EOF

## Next Steps

1. **Review this report** and address any missing repositories
2. **Initialize Task Master** in repositories marked with ❌
3. **Set up GitHub Actions** for automated synchronization
4. **Configure Slack integration** for notifications
5. **Create cross-repository tasks** in project-nexus

## Commands to Complete Setup

\`\`\`bash
# For any repository missing Task Master:
cd /path/to/repository
task-master init --name="repository-name" --yes

# Copy configuration from mandible:
cp ${MANDIBLE_CONFIG_SOURCE} .taskmaster/config.json
\`\`\`
EOF

    print_success "Status report generated: $report_file"
}

# Main execution
main() {
    print_header "WeirdBrains Cross-Repository Task Master Setup"
    
    # Check prerequisites
    check_prerequisites
    
    # Create base directory if it doesn't exist
    mkdir -p "$BASE_DIR"
    
    # Clone and initialize core repositories
    print_header "Setting up Core Repositories"
    for repo in "${CORE_REPOS[@]}"; do
        if clone_repo_if_needed "$repo"; then
            init_taskmaster_in_repo "$repo"
        fi
    done
    
    # Set up project-nexus as master coordinator
    setup_project_nexus
    
    # Create cross-repository task template
    create_cross_repo_task_template
    
    # Generate status report
    generate_status_report
    
    print_header "Setup Complete!"
    print_success "Task Master has been set up across WeirdBrains repositories"
    print_info "Review the generated report for next steps: ${BASE_DIR}/taskmaster_setup_report.md"
    print_info "Next: Set up GitHub Actions and Slack integration for full automation"
}

# Run main function
main "$@"
