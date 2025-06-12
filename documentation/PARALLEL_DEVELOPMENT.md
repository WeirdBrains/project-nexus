# WeirdBrains Parallel Development Strategy

## 🎯 Overview

This strategy allows simultaneous:
1. **Remote agent development** on core features
2. **System reorganization** and optimization
3. **Continuous integration** and deployment

## 🤖 Agent Assignments

### Factory.ai Backend Agent
- **Workspace**: `WeirdBrains-v2/workspaces/auth-system/`
- **Focus**: Authentication, user management, backend services
- **Repositories**: sso_backend, accounts
- **Branch**: `feature/task-master-integration`

### Factory.ai Frontend Agent
- **Workspace**: `WeirdBrains-v2/workspaces/mobile-app/`
- **Focus**: Mobile app, UI/UX, frontend features
- **Repositories**: mandible, accounts
- **Branch**: `feature/task-master-integration`

### Augment Agent
- **Workspace**: `WeirdBrains-v2/workspaces/full-stack/`
- **Focus**: System coordination, integration, architecture
- **Repositories**: All repositories
- **Branch**: `feature/task-master-integration`

## 🔄 Development Workflow

### Daily Agent Workflow
```bash
# 1. Start development environment
./WeirdBrains-v2/scripts/agents/start-development.sh [backend|frontend|fullstack]

# 2. Work in assigned workspace
cd WeirdBrains-v2/workspaces/<your-workspace>/

# 3. Make changes and commit
git add .
git commit -m "feat: implement feature"
git push origin feature/task-master-integration

# 4. Update Task Master status
cd ../../coordination/project-nexus/
# Update task progress
```

### Integration Workflow
```bash
# Check all agent progress
./WeirdBrains-v2/scripts/agents/check-progress.sh

# Test integration in full-stack workspace
cd WeirdBrains-v2/workspaces/full-stack/
# Run integration tests

# Merge to main when ready
git checkout main
git merge feature/task-master-integration
git push origin main
```

## 🏗️ Parallel Reorganization

While agents develop, system reorganization continues:
1. **Archive old duplicates** → `WeirdBrains-archive/`
2. **Move experimental projects** → `WeirdBrains-experimental/`
3. **Organize documentation** → `WeirdBrains-v2/documentation/`
4. **Optimize structure** for long-term maintainability

## 🚀 Benefits

### For Remote Agents
- **Isolated workspaces** prevent conflicts
- **Clear focus areas** improve productivity
- **Stable development environment** during reorganization

### For System Organization
- **Non-disruptive reorganization** while development continues
- **Gradual migration** to new structure
- **Preserved development velocity**

### For Integration
- **Feature branch strategy** enables safe integration
- **Task Master coordination** tracks all progress
- **Full-stack testing** ensures system coherence

## 📋 Commands Reference

```bash
# Start agent development
./scripts/agents/start-development.sh [backend|frontend|fullstack]

# Check development progress
./scripts/agents/check-progress.sh

# Sync Git branches
./scripts/sync-git-branches.sh status

# Switch workspaces
./scripts/switch-workspace.sh <workspace-name>

# Test migration progress
./scripts/test-migration.sh
```

## ⚠️ Important Notes

- **Always work on feature branch** (`feature/task-master-integration`)
- **Commit frequently** to avoid conflicts
- **Use Task Master** for coordination
- **Test in full-stack workspace** before merging
- **Coordinate deployments** through human oversight
