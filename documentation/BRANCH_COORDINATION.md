# WeirdBrains Branch Coordination & Task Master Integration

## 🎯 Current Status: SAFELY MIGRATED TO FEATURE BRANCH

✅ **SUCCESS**: Task Master setup moved from production to feature branch  
✅ **SAFE**: Production branches are now clean of Task Master files  
✅ **READY**: Cross-repository coordination can now be implemented safely  

## 📋 Repository Structure & Branch Status

### Main Repository: WeirdBrains/mandible
- **Current Branch**: `feature/task-master-integration`
- **Task Master Location**: `mandible_app/.taskmaster/`
- **Status**: ✅ Safe for development

### Submodules/Related Repositories:
- **backend**: `main` branch (needs Task Master setup)
- **sso_backend**: `production` branch ⚠️ (needs migration)
- **accounts**: `main` branch (needs Task Master setup)
- **project-nexus**: `main` branch (needs Task Master setup)

## 🔄 GitHub Branch Integration Strategy

### 1. Branch-Aware Task Creation
```bash
# Always check current branch before creating tasks
git branch --show-current

# Create tasks only on feature branches
cd mandible_app
task-master add-task --title="Feature Task" --description="Branch: $(git branch --show-current)"
```

### 2. Cross-Repository Branch Coordination
```json
{
  "branchCoordination": {
    "featureBranch": "feature/task-master-integration",
    "repositories": {
      "mandible": {
        "currentBranch": "feature/task-master-integration",
        "taskMasterPath": "mandible_app/.taskmaster/",
        "status": "ready"
      },
      "backend": {
        "targetBranch": "feature/task-master-integration", 
        "taskMasterPath": ".taskmaster/",
        "status": "needs-setup"
      },
      "sso_backend": {
        "currentBranch": "production",
        "targetBranch": "feature/task-master-integration",
        "status": "needs-migration"
      }
    }
  }
}
```

### 3. Task-to-Branch Mapping
```bash
# Link tasks to specific branches
task-master update-task --id=X --prompt="Working on branch: feature/task-master-integration"

# Create branch-specific tasks
task-master add-task \
  --title="Implement Authentication API" \
  --description="Branch: feature/auth-improvements, Repo: sso_backend"
```

## 🚀 Implementation Plan for GitHub Integration

### Phase 1: Complete Current Repository Setup
```bash
# 1. Commit current Task Master setup
git add mandible_app/.taskmaster/
git commit -m "Add Task Master integration on feature branch"

# 2. Create branch coordination documentation
git add BRANCH_COORDINATION.md
git commit -m "Add branch coordination documentation"

# 3. Test Task Master functionality
cd mandible_app
task-master list
task-master next
```

### Phase 2: Set Up Other Repositories
```bash
# For each repository (backend, sso_backend, accounts):
# 1. Create feature branch
git checkout -b feature/task-master-integration

# 2. Initialize Task Master
task-master init --name="repository-name" --yes

# 3. Copy configuration from mandible
cp ../mandible_app/.taskmaster/config.json .taskmaster/

# 4. Create initial tasks
task-master add-task --title="Setup complete" --description="Task Master initialized"
```

### Phase 3: GitHub Actions Integration
```yaml
# .github/workflows/taskmaster-branch-sync.yml
name: TaskMaster Branch Coordination

on:
  push:
    branches: [ feature/task-master-integration ]
  pull_request:
    branches: [ main ]

jobs:
  sync-tasks:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install Task Master
        run: npm install -g task-master-ai
      - name: Sync branch tasks
        run: |
          echo "Branch: ${{ github.ref_name }}"
          echo "Repository: ${{ github.repository }}"
          # Future: Add cross-repo sync logic
```

## 🔧 Branch Management Commands

### Daily Workflow Commands
```bash
# Check current branch across all repos
./check_all_branches.sh

# Ensure on feature branch
git checkout feature/task-master-integration

# Work with Task Master (only on feature branch!)
cd mandible_app
task-master list
task-master next
task-master add-task --title="New feature" --description="Safe development"
```

### Safety Commands
```bash
# Verify no Task Master files on production
git checkout production 2>/dev/null || git checkout main
find . -name ".taskmaster" -type d  # Should return nothing

# Switch back to feature branch
git checkout feature/task-master-integration
```

## 🛡️ Safety Rules & Best Practices

### ❌ NEVER DO:
- Create Task Master tasks on production branch
- Commit `.taskmaster/` directories to production
- Merge Task Master setup to production without thorough testing
- Work on Task Master coordination on main/production branches

### ✅ ALWAYS DO:
- Work on `feature/task-master-integration` branch
- Test Task Master functionality thoroughly before merging
- Create branch-aware task descriptions
- Document cross-repository dependencies
- Use feature branches for all Task Master development

## 📊 Current Task Coordination Status

### Project Nexus Tasks (Coordination Hub):
1. ✅ **Task 1**: Cross-Repository Image Processing Coordination
2. 🔄 **Task 2**: Document Cross-Repository Task Management System (in-progress)
3. ⏳ **Task 3**: Set up GitHub Actions for Cross-Repo Sync
4. ⏳ **Task 4**: Configure Slack Integration for Task Notifications
5. 🔄 **Task 5**: Migrate Task Master Setup from Production to Feature Branches (in-progress)

### Mandible App Tasks (25 tasks):
- All tasks safely preserved on feature branch
- Ready for cross-repository coordination
- Can be linked to other repository tasks

## 🔄 Next Steps

### Immediate (Today):
1. ✅ Complete migration to feature branch
2. ⏳ Test Task Master functionality on feature branch
3. ⏳ Create cross-repository coordination tasks
4. ⏳ Set up GitHub Actions for branch awareness

### Short Term (This Week):
1. Set up Task Master in other repositories (on feature branches)
2. Create cross-repository task dependencies
3. Implement Slack integration for notifications
4. Test full coordination workflow

### Medium Term (Next Week):
1. Create pull requests for Task Master integration
2. Merge to main after thorough testing
3. Deploy coordination system to production
4. Train team on new workflow

## 🆘 Troubleshooting

### "Task Master not working"
```bash
# Ensure on correct branch
git branch --show-current  # Should show: feature/task-master-integration

# Check Task Master location
ls -la mandible_app/.taskmaster/

# Test Task Master
cd mandible_app && task-master list
```

### "Can't create tasks"
```bash
# Verify you're on feature branch, not production
git branch --show-current

# If on wrong branch:
git checkout feature/task-master-integration
```

### "Cross-repository coordination not working"
```bash
# Check if other repos have Task Master setup
cd ../backend && ls -la .taskmaster/  # Should exist
cd ../sso_backend && git branch --show-current  # Should be feature branch
```

---

**🎉 SUCCESS**: Task Master integration safely moved to feature branch!  
**📍 Current Branch**: `feature/task-master-integration`  
**🔒 Production Safety**: Confirmed clean  
**🚀 Ready For**: Cross-repository coordination development
