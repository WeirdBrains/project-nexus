# WeirdBrains Cross-Repository Task Coordination System

## 🎯 Repository Architecture

**Parent Directory**: `/home/zack-mohorn/Desktop/Code/WeirdBrains/`

**Separate GitHub Repositories**:
- **🎮 mandible** - Main Flutter application
- **🔧 backend** - Dart Frog API service  
- **🔐 sso_backend** - Authentication service
- **👤 accounts** - SSO frontend interface
- **🎯 project-nexus** - Master coordinator (THIS REPO)
- **🖼️ moire** - AI image processing service

## 🎯 Project-Nexus: Master Coordinator Role

As the master coordinator, project-nexus:
1. **Tracks tasks across all repositories**
2. **Manages cross-repository dependencies**
3. **Coordinates AI agent assignments**
4. **Provides unified progress reporting**
5. **Handles GitHub branch integration**

## 📋 Current Repository Status

### Branch Status Check:
```bash
# From parent directory: /home/zack-mohorn/Desktop/Code/WeirdBrains/
mandible:     feature/task-master-integration ✅
backend:      main ✅
sso_backend:  production ⚠️ (needs feature branch)
accounts:     main ✅
project-nexus: main ✅ (master coordinator)
moire:        main ✅
```

### Task Master Status:
```bash
mandible:     ✅ Initialized (mandible_app/.taskmaster/)
backend:      ❌ Needs initialization
sso_backend:  ❌ Needs initialization + branch fix
accounts:     ❌ Needs initialization
project-nexus: ✅ Initialized (master coordinator)
moire:        ✅ Initialized
```

## 🔗 Cross-Repository Task Coordination

### Master Task Structure:
```json
{
  "crossRepoTasks": [
    {
      "id": "nexus-auth-flow",
      "title": "Complete Authentication Integration",
      "masterRepo": "project-nexus",
      "repositories": {
        "sso_backend": {
          "tasks": ["auth-api-endpoints", "token-management"],
          "status": "pending",
          "branch": "feature/auth-improvements"
        },
        "accounts": {
          "tasks": ["login-ui", "registration-flow"],
          "status": "pending", 
          "dependencies": ["sso_backend.auth-api-endpoints"]
        },
        "mandible": {
          "tasks": ["sso-integration", "session-management"],
          "status": "pending",
          "dependencies": ["accounts.login-ui"]
        }
      },
      "criticalPath": ["sso_backend.auth-api-endpoints", "accounts.login-ui", "mandible.sso-integration"],
      "assignedAgents": {
        "sso_backend": "factory-ai-backend",
        "accounts": "factory-ai-frontend", 
        "mandible": "factory-ai-frontend"
      }
    }
  ]
}
```

## 🤖 AI Agent Assignment Matrix

| Repository | Primary Agent | Technologies | Task Types |
|------------|---------------|-------------|------------|
| **mandible** | factory-ai-frontend | Flutter, Riverpod, Dart | UI development, state management |
| **backend** | factory-ai-backend | Dart Frog, PostgreSQL | API development, database design |
| **sso_backend** | factory-ai-backend | Dart Frog, Auth | Authentication, security |
| **accounts** | factory-ai-frontend | Flutter, UI | SSO interface, user management |
| **moire** | factory-ai-backend | AI/ML, Image Processing | AI model integration |
| **project-nexus** | augment-agent | Coordination, Documentation | Task management, reporting |

## 🚀 Implementation Plan

### Phase 1: Repository Setup (This Week)
```bash
# 1. Fix sso_backend production branch issue
cd ../sso_backend
git checkout main  # or create from main
git checkout -b feature/task-master-integration

# 2. Initialize Task Master in each repo
cd ../backend && task-master init --name="backend" --yes
cd ../sso_backend && task-master init --name="sso_backend" --yes  
cd ../accounts && task-master init --name="accounts" --yes

# 3. Copy configuration from project-nexus
cp ../project-nexus/.taskmaster/config.json .taskmaster/
```

### Phase 2: Cross-Repository Task Creation
```bash
# In project-nexus (master coordinator)
task-master add-task --title="Authentication Flow Integration" \
  --description="Coordinate SSO implementation across sso_backend, accounts, and mandible"

# Create repository-specific tasks
cd ../sso_backend
task-master add-task --title="SSO API Endpoints" \
  --description="Build authentication API (coordinated via project-nexus.auth-flow)"

cd ../accounts  
task-master add-task --title="SSO Login Interface" \
  --description="Build login UI (depends on sso_backend.api-endpoints)"
```

### Phase 3: GitHub Integration
```yaml
# .github/workflows/cross-repo-sync.yml (in each repository)
name: Cross-Repository Task Sync
on:
  issues: [opened, closed, edited]
  push: [main, feature/*]
jobs:
  notify-nexus:
    runs-on: ubuntu-latest
    steps:
      - name: Notify project-nexus
        run: |
          curl -X POST https://api.github.com/repos/WeirdBrains/project-nexus/dispatches \
            -H "Authorization: token ${{ secrets.NEXUS_TOKEN }}" \
            -d '{"event_type": "repo_update", "client_payload": {"repo": "${{ github.repository }}", "event": "${{ github.event_name }}"}}'
```

## 📊 Coordination Commands

### Daily Workflow:
```bash
# Check status across all repositories
cd /home/zack-mohorn/Desktop/Code/WeirdBrains/project-nexus
./scripts/check-all-repos.sh

# View cross-repository tasks
task-master list

# Create cross-repository task
task-master add-task --title="Feature Name" \
  --description="Coordinates: backend.task-X, mandible.task-Y"

# Update task with cross-repo progress
task-master update-task --id=X --prompt="Backend API complete, frontend UI in progress"
```

### Repository-Specific Work:
```bash
# Work on backend tasks
cd ../backend
task-master next  # See what to work on
task-master set-status --id=X --status=in-progress

# When complete, update coordination
cd ../project-nexus
task-master update-task --id=Y --prompt="Backend task X completed, unblocking frontend work"
```

## 🔧 Branch Management Integration

### Branch-Aware Task Creation:
```bash
# Always include branch context in tasks
task-master add-task --title="Feature Implementation" \
  --description="Branch: feature/task-master-integration, Repo: backend, Coordinates with: mandible.ui-task"
```

### Cross-Repository Branch Coordination:
```json
{
  "branchCoordination": {
    "featureBranch": "feature/task-master-integration",
    "repositories": {
      "mandible": {"branch": "feature/task-master-integration", "status": "active"},
      "backend": {"branch": "feature/task-master-integration", "status": "needs-creation"},
      "sso_backend": {"branch": "production", "status": "needs-migration"},
      "accounts": {"branch": "feature/task-master-integration", "status": "needs-creation"},
      "moire": {"branch": "feature/task-master-integration", "status": "needs-creation"}
    }
  }
}
```

## 🛡️ Safety Rules

### ❌ NEVER:
- Create tasks on production branches
- Merge Task Master setup to production without testing
- Work on cross-repository coordination without project-nexus oversight

### ✅ ALWAYS:
- Use project-nexus as the source of truth for cross-repository coordination
- Create feature branches for Task Master integration
- Document cross-repository dependencies in task descriptions
- Update project-nexus when repository tasks are completed

## 📈 Progress Tracking

### Weekly Reports:
- Cross-repository task completion rates
- AI agent performance across repositories  
- Bottleneck identification and resolution
- Dependency chain optimization

### Real-time Coordination:
- Slack notifications when cross-repository tasks are completed
- GitHub issue synchronization across repositories
- Automated dependency checking and unblocking

---

**🎯 Project-Nexus Mission**: Coordinate all WeirdBrains development activities across 6 separate repositories with unified task management, AI agent coordination, and seamless cross-repository dependency tracking.
