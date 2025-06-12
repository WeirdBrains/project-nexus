# WeirdBrains Project Nexus - Cross-Repository Task Management System

## 🎯 Overview

Project Nexus is the central coordination hub for all WeirdBrains development activities. It provides unified task management, AI agent coordination, and cross-repository synchronization across our entire development ecosystem.

## 🏗️ System Architecture

### Repository Structure
```
WeirdBrains Ecosystem
├── project-nexus/          ← Master Coordinator (YOU ARE HERE)
├── mandible_app/           ← Flutter Frontend (25 active tasks)
├── backend/                ← Dart Frog API Service
├── sso_backend/            ← Authentication Service
├── accounts/               ← SSO Frontend
├── moire/                  ← AI Image Processing
├── infrastructure/         ← DevOps & Deployment
└── onesignal-mcp/         ← Push Notifications
```

### Task Coordination Flow
```
1. Master tasks created in project-nexus
2. Repository-specific tasks created in individual repos
3. Dependencies linked across repositories
4. AI agents assigned based on capability matrix
5. Progress tracked centrally with automated notifications
```

## 🤖 AI Agent Assignment Matrix

| Agent | Repositories | Technologies | Task Types |
|-------|-------------|-------------|------------|
| **factory-ai-backend** | backend, sso_backend, moire, infrastructure | Dart Frog, PostgreSQL, Kubernetes | API development, database design, infrastructure |
| **factory-ai-frontend** | mandible_app, accounts, sso_widgets | Flutter, Riverpod, UI design | UI development, state management, UX |
| **augment-agent** | All repositories | Code analysis, optimization, debugging | Code review, performance optimization, bug fixing |
| **human-developer** | All repositories | Architecture, complex integration | System design, critical decisions, architecture |

## 📋 Current Task Status

### Project Nexus System Building (4 tasks)
- ✅ **Task 1**: Cross-Repository Image Processing Coordination (pending)
- 🔄 **Task 2**: Document Cross-Repository Task Management System (in-progress)
- ⏳ **Task 3**: Set up GitHub Actions for Cross-Repo Sync (pending)
- ⏳ **Task 4**: Configure Slack Integration for Task Notifications (pending)

### Mandible App Development (25 tasks)
**High Priority Foundation:**
- Task 1: Setup Project Repository
- Task 2: Configure PostgreSQL Database  
- Task 3: Implement ONNX Runtime Integration
- Task 4: Build Image Processing Service

**AI Integration:**
- Task 9: Integrate DigitalOcean GenAI Platform API
- Task 10: Build DA3 Chat Interface
- Task 11: Implement Image Analysis Endpoints

**Security & Compliance:**
- Task 7: Implement HIPAA-Compliant Audit Logging
- Task 21: Implement Data Privacy and Consent Management
- Task 22: Secure Storage and Transmission of Sensitive Data

## 🔗 Cross-Repository Dependencies

### Image Processing Pipeline
```
moire (AI Model) → backend (API) → mandible_app (UI)
├── moire: ONNX Runtime Integration
├── backend: Image Processing Service + API Endpoints
└── mandible_app: Image Processing Widgets + UI
```

### Authentication Flow
```
sso_backend (Auth API) → accounts (SSO UI) → mandible_app (Integration)
├── sso_backend: Authentication endpoints
├── accounts: Login/registration UI
└── mandible_app: SSO integration
```

### Notification System
```
onesignal-mcp (Integration) → backend (API) → mandible_app (UI)
├── onesignal-mcp: MCP integration
├── backend: Notification API
└── mandible_app: Real-time notifications
```

## 🚀 Getting Started for Team Members

### 1. Prerequisites
```bash
# Install Node.js and npm
node --version  # Should show v16+
npm --version   # Should show v8+

# Install Task Master AI globally
npm install -g task-master-ai

# Verify installation
task-master --version
```

### 2. Repository Setup
```bash
# Clone all repositories
cd ~/Desktop/Code/WeirdBrains/
git clone https://github.com/WeirdBrains/project-nexus.git
git clone https://github.com/WeirdBrains/mandible.git
git clone https://github.com/WeirdBrains/backend.git
git clone https://github.com/WeirdBrains/sso_backend.git
git clone https://github.com/WeirdBrains/accounts.git

# Each repository already has Task Master initialized
# Configuration is synchronized across all repos
```

### 3. Daily Workflow

#### For Human Developers:
```bash
# 1. Check what to work on next
cd ~/Desktop/Code/WeirdBrains/project-nexus
task-master next

# 2. View cross-repository status
task-master list

# 3. Start working on a task
task-master set-status --id=X --status=in-progress

# 4. When complete, mark as done
task-master set-status --id=X --status=done
```

#### For AI Agents:
- Tasks are automatically assigned based on capability matrix
- Agents receive notifications via Slack when tasks become available
- Progress is tracked automatically through GitHub integration

### 4. Creating Cross-Repository Tasks
```bash
# In project-nexus (master coordinator)
task-master add-task --title="Feature Name" --description="Cross-repo coordination details"

# Add dependencies to other repositories
task-master add-dependency --id=X --depends-on="backend.task-Y"
task-master add-dependency --id=X --depends-on="mandible.task-Z"
```

## 🔧 Integration Points

### GitHub Integration
- **Issues ↔ Tasks**: GitHub issues automatically sync with Task Master tasks
- **PR Status**: Pull request status updates task progress
- **Labels**: GitHub labels map to task priorities and types

### Slack Integration
- **#development**: General development updates
- **#ai-agents**: AI agent assignments and status
- **#alerts**: Critical issues and blockers
- **#task-updates**: Real-time task status changes

### Sentry Integration
- **Error → Task**: Sentry errors automatically create bug fix tasks
- **Performance**: Performance issues trigger optimization tasks

## 📊 Progress Tracking

### Repository Health Dashboard
```bash
# View overall progress across all repositories
cd ~/Desktop/Code/WeirdBrains/project-nexus
./coordination/sync-repos.sh
```

### Weekly Reports
- Automated weekly progress reports sent to #development
- Velocity tracking and bottleneck identification
- AI agent performance metrics

## 🆘 Troubleshooting

### Common Issues
1. **Task Master not found**: Run `npm install -g task-master-ai`
2. **Configuration sync issues**: Copy config from mandible_app: `cp ../mandible_app/.taskmaster/config.json .taskmaster/`
3. **GitHub sync not working**: Check webhook configuration in repository settings
4. **Slack notifications missing**: Verify webhook URLs in coordination config

### Support
- **Documentation**: This README and files in `/documentation/`
- **Team Lead**: @zackmohorn
- **AI Agents**: Available 24/7 for task assignment and coordination

## 📁 Directory Structure
```
project-nexus/
├── README.md                          ← This file
├── coordination/
│   ├── master-tasks.json              ← Cross-repo task coordination
│   ├── sync-repos.sh                  ← Repository sync script
│   └── agent-assignments.json         ← AI agent workload tracking
├── documentation/
│   ├── team-onboarding.md             ← New team member guide
│   ├── ai-agent-protocols.md          ← AI agent coordination rules
│   └── workflow-examples.md           ← Common workflow patterns
├── .taskmaster/
│   ├── tasks/tasks.json               ← Project Nexus tasks
│   └── config.json                    ← Task Master configuration
└── .github/
    └── workflows/
        └── cross-repo-sync.yml        ← GitHub Actions for automation
```

---

**Last Updated**: 2025-01-01 by Augment Agent  
**Next Review**: Weekly team sync meetings  
**Status**: 🔄 Active Development
