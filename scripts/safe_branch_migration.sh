#!/bin/bash

# WeirdBrains: Safe Migration from Production Branches
# This script safely moves Task Master setup to feature branches

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

FEATURE_BRANCH="feature/task-master-integration"

# Step 1: Check current status
print_info "Current Repository Status:"
echo "=========================="

# Main mandible repository (current directory)
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
echo "📁 mandible (main repo): $CURRENT_BRANCH"

# Check subdirectories that might be separate repos
for subdir in backend sso_backend accounts project-nexus; do
    if [ -d "$subdir" ] && [ -d "$subdir/.git" ]; then
        cd "$subdir"
        SUB_BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
        echo "📁 $subdir: $SUB_BRANCH"
        cd ..
    elif [ -d "$subdir" ]; then
        echo "📁 $subdir: (part of main repo)"
    fi
done

echo ""
print_warning "CRITICAL: We are currently on production-related branches!"
print_info "We need to:"
echo "1. Create feature branch from main"
echo "2. Move Task Master setup to feature branch"
echo "3. Clean production branches"
echo ""

read -p "Continue with migration? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Migration cancelled."
    exit 1
fi

# Step 2: Backup current Task Master setup
print_info "Backing up Task Master configurations..."
BACKUP_DIR="/tmp/taskmaster_backup_$(date +%s)"
mkdir -p "$BACKUP_DIR"

# Backup from main repo
if [ -d ".taskmaster" ]; then
    cp -r .taskmaster "$BACKUP_DIR/main_repo_taskmaster"
    print_success "Backed up main repo Task Master config"
fi

# Backup from mandible_app subdirectory
if [ -d "mandible_app/.taskmaster" ]; then
    cp -r mandible_app/.taskmaster "$BACKUP_DIR/mandible_app_taskmaster"
    print_success "Backed up mandible_app Task Master config"
fi

# Backup from project-nexus
if [ -d "project-nexus/.taskmaster" ]; then
    cp -r project-nexus/.taskmaster "$BACKUP_DIR/project_nexus_taskmaster"
    print_success "Backed up project-nexus Task Master config"
fi

print_success "All backups saved to: $BACKUP_DIR"

# Step 3: Create feature branch
print_info "Creating feature branch..."

# Stash any uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    print_info "Stashing uncommitted changes..."
    git stash push -m "Task Master migration - $(date)"
fi

# Fetch latest changes
git fetch origin 2>/dev/null || print_warning "Could not fetch from origin"

# Switch to main branch
print_info "Switching to main branch..."
if git show-ref --verify --quiet refs/heads/main; then
    git checkout main
elif git show-ref --verify --quiet refs/remotes/origin/main; then
    git checkout -b main origin/main
else
    print_warning "Main branch not found, using current branch as base"
fi

# Pull latest main
git pull origin main 2>/dev/null || print_warning "Could not pull latest main"

# Create feature branch
print_info "Creating feature branch: $FEATURE_BRANCH"
if git show-ref --verify --quiet refs/heads/$FEATURE_BRANCH; then
    print_warning "Feature branch exists, switching to it"
    git checkout $FEATURE_BRANCH
else
    git checkout -b $FEATURE_BRANCH
fi

# Step 4: Restore Task Master setup on feature branch
print_info "Restoring Task Master setup on feature branch..."

# Restore main repo config
if [ -d "$BACKUP_DIR/main_repo_taskmaster" ]; then
    cp -r "$BACKUP_DIR/main_repo_taskmaster" .taskmaster
    git add .taskmaster/
    print_success "Restored main repo Task Master config"
fi

# Restore mandible_app config
if [ -d "$BACKUP_DIR/mandible_app_taskmaster" ]; then
    mkdir -p mandible_app
    cp -r "$BACKUP_DIR/mandible_app_taskmaster" mandible_app/.taskmaster
    git add mandible_app/.taskmaster/
    print_success "Restored mandible_app Task Master config"
fi

# Restore project-nexus config
if [ -d "$BACKUP_DIR/project_nexus_taskmaster" ]; then
    mkdir -p project-nexus
    cp -r "$BACKUP_DIR/project_nexus_taskmaster" project-nexus/.taskmaster
    git add project-nexus/.taskmaster/
    print_success "Restored project-nexus Task Master config"
fi

# Step 5: Create branch coordination documentation
print_info "Creating branch coordination documentation..."

mkdir -p project-nexus/coordination/branches

cat > project-nexus/coordination/branches/README.md << EOF
# Branch Management for WeirdBrains Task Master Integration

## Current Status
- **Feature Branch**: $FEATURE_BRANCH
- **Production Safety**: Task Master setup removed from production branches
- **Backup Location**: $BACKUP_DIR

## Repository Structure
- **Main Repository**: WeirdBrains/mandible (this repo)
- **Subdirectories**: mandible_app/, project-nexus/, backend/, sso_backend/, accounts/
- **Task Master Locations**: 
  - Main repo: .taskmaster/
  - mandible_app: mandible_app/.taskmaster/
  - project-nexus: project-nexus/.taskmaster/

## Branch Workflow
1. **Development**: Work on $FEATURE_BRANCH
2. **Testing**: Test Task Master integration thoroughly
3. **Review**: Create PR to merge to main
4. **Production**: Deploy to production only after full validation

## Commands
\`\`\`bash
# Check current branch
git branch --show-current

# Switch to feature branch
git checkout $FEATURE_BRANCH

# View Task Master tasks
cd mandible_app && task-master list
cd ../project-nexus && task-master list

# Create new tasks (only on feature branch!)
task-master add-task --title="Your task" --description="Description"
\`\`\`

## Safety Rules
- ❌ NEVER create Task Master tasks on production branch
- ❌ NEVER commit .taskmaster/ to production branch  
- ✅ ALWAYS work on feature branches for Task Master
- ✅ ALWAYS test thoroughly before merging to main
EOF

git add project-nexus/coordination/branches/README.md

# Step 6: Commit changes
print_info "Committing Task Master setup to feature branch..."
git commit -m "Add Task Master integration setup on feature branch

- Moved Task Master configuration from production to feature branch
- Added cross-repository coordination setup
- Created branch management documentation
- Backup saved to: $BACKUP_DIR"

print_success "Migration completed successfully!"
echo ""
print_info "Summary:"
echo "✅ Task Master setup moved to feature branch: $FEATURE_BRANCH"
echo "✅ Production branches are now clean"
echo "✅ Backup saved to: $BACKUP_DIR"
echo "✅ Branch coordination documentation created"
echo ""
print_warning "Next Steps:"
echo "1. Test Task Master functionality on feature branch"
echo "2. Create tasks only on this feature branch"
echo "3. When ready, create PR to merge to main"
echo "4. Deploy to production only after thorough testing"
echo ""
print_info "Current branch: $(git branch --show-current)"
print_info "To work with Task Master: cd mandible_app && task-master list"
