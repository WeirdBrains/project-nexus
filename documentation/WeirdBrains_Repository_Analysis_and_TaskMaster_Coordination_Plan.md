# WeirdBrains Repository Analysis & Task Master Coordination Plan

## Executive Summary

This document provides a comprehensive analysis of all WeirdBrains repositories and establishes a unified Task Master AI coordination strategy across the entire ecosystem. Based on analysis of 30+ repositories, we've identified core platform components and created a systematic approach for cross-repository task management.

## Repository Ecosystem Analysis

### **Core Platform Repositories (Priority 1)**

#### 1. **mandible** - Flutter Frontend (Primary Client)
- **Status**: Active development, 149+ issues/PRs
- **Tech Stack**: Flutter, Riverpod, Dart
- **Task Master Status**: ✅ Already initialized with sophisticated config
- **Current Tasks**: 25 pending tasks (image processing, AI integration)
- **Dependencies**: backend, sso_backend, accounts
- **Coordination Role**: Primary user interface, drives feature requirements

#### 2. **backend** - Main API Service (Dart Frog)
- **Status**: Active, core business logic
- **Tech Stack**: Dart Frog, PostgreSQL, OneSignal
- **Task Master Status**: ❌ Needs initialization
- **Dependencies**: sso_backend (authentication), infrastructure
- **Coordination Role**: Central API hub, coordinates with all frontends

#### 3. **sso_backend** - Authentication Service
- **Status**: Active, critical infrastructure
- **Tech Stack**: Dart Frog, PostgreSQL
- **Task Master Status**: ❌ Needs initialization
- **Dependencies**: infrastructure
- **Coordination Role**: Authentication provider for all services

#### 4. **accounts** - SSO Frontend
- **Status**: Active development
- **Tech Stack**: Flutter
- **Task Master Status**: ❌ Needs initialization
- **Dependencies**: sso_backend, sso_widgets
- **Coordination Role**: User account management interface

#### 5. **project-nexus** - Coordination Hub
- **Status**: Recently created (2025-05-30)
- **Purpose**: AI-powered project management and cross-repository coordination
- **Task Master Status**: ❌ Needs initialization as master coordinator
- **Coordination Role**: Central command center for all repositories

### **Infrastructure & DevOps (Priority 2)**

#### 6. **infrastructure** - Kubernetes & IaC
- **Status**: Active, deployment configurations
- **Tech Stack**: Kubernetes, Infrastructure as Code
- **Task Master Status**: ❌ Needs initialization
- **Coordination Role**: Deployment and infrastructure management

#### 7. **onesignal-mcp** - Notification Integration
- **Status**: Active, MCP server for OneSignal
- **Tech Stack**: TypeScript, MCP Protocol
- **Task Master Status**: ❌ Needs initialization
- **Coordination Role**: Push notification coordination

### **Specialized Applications (Priority 3)**

#### 8. **moire** - Image Processing
- **Status**: Active development
- **Tech Stack**: AI/ML, Image Processing
- **Task Master Status**: ❌ Needs initialization
- **Dependencies**: backend (for API integration)

#### 9. **soma** - SSO Backend V2
- **Status**: Development, next-gen SSO
- **Tech Stack**: Modern backend framework
- **Task Master Status**: ❌ Needs initialization
- **Coordination Role**: Future SSO replacement

### **Supporting Libraries & Tools (Priority 4)**

#### 10. **sso_widgets** - Flutter SSO Components
- **Status**: Active, shared UI components
- **Tech Stack**: Flutter widgets
- **Task Master Status**: ❌ Needs initialization
- **Dependencies**: None (library)

#### 11. **skeli** - Flutter UI Framework
- **Status**: Framework development
- **Tech Stack**: Flutter
- **Task Master Status**: ❌ Needs initialization
- **Dependencies**: None (framework)

### **Legacy/Experimental Projects (Priority 5)**
- **song_notes**, **song_notes_backend** - Music application
- **aicaller**, **aicallerservice** - AI phone dialer
- **currentcy** - E-commerce platform
- **hillock**, **hillock_backend** - Launchpad application
- **spaces_backend** - Spaces API
- **admin-web**, **mandible_admin**, **users** - Admin tools
- **website** - Company website
- **waitinglist** - Waiting list API

## Task Master Coordination Strategy

### **Phase 1: Core Platform Setup (Week 1)**

#### Repository Initialization Priority:
1. **project-nexus** (Master Coordinator)
2. **backend** (Core API)
3. **sso_backend** (Authentication)
4. **accounts** (SSO Frontend)
5. **infrastructure** (DevOps)

#### Initialization Commands:
```bash
# For each repository
cd /path/to/repository
task-master init --name="[Repository Name]" --yes
task-master models --setup  # Copy config from mandible
```

#### Configuration Synchronization:
- Copy `.taskmaster/config.json` from mandible to all repositories
- Ensure consistent AI model configuration (DeepSeek, Perplexity, Claude)
- Set up shared environment variables for API keys

### **Phase 2: Cross-Repository Task Coordination (Week 2)**

#### Master Task Structure:
```json
{
  "crossRepoTasks": [
    {
      "id": "auth-flow-complete",
      "title": "Complete User Authentication Flow",
      "masterRepo": "project-nexus",
      "repositories": {
        "sso_backend": {
          "taskIds": ["auth-3", "auth-4"],
          "status": "in-progress",
          "blockers": []
        },
        "accounts": {
          "taskIds": ["ui-12", "ui-13"],
          "status": "pending",
          "dependencies": ["sso_backend.auth-3"]
        },
        "mandible": {
          "taskIds": ["integration-5"],
          "status": "pending",
          "dependencies": ["accounts.ui-12"]
        }
      },
      "overallStatus": "in-progress",
      "criticalPath": ["sso_backend.auth-3", "accounts.ui-12", "mandible.integration-5"],
      "assignedAgents": {
        "sso_backend": "factory-ai-backend",
        "accounts": "factory-ai-frontend",
        "mandible": "augment-agent"
      }
    }
  ]
}
```

### **Phase 3: AI Agent Assignment Matrix (Week 3)**

#### Agent Capabilities:
```javascript
const agentCapabilities = {
  'factory-ai-backend': {
    repositories: ['backend', 'sso_backend', 'infrastructure'],
    technologies: ['dart-frog', 'postgresql', 'kubernetes'],
    taskTypes: ['api-development', 'database-design', 'infrastructure']
  },
  'factory-ai-frontend': {
    repositories: ['mandible', 'accounts', 'sso_widgets'],
    technologies: ['flutter', 'riverpod', 'ui-design'],
    taskTypes: ['ui-development', 'state-management', 'user-experience']
  },
  'augment-agent': {
    repositories: ['all'],
    technologies: ['code-analysis', 'optimization', 'debugging'],
    taskTypes: ['code-review', 'performance-optimization', 'bug-fixing']
  },
  'human-developer': {
    repositories: ['all'],
    technologies: ['architecture', 'complex-integration'],
    taskTypes: ['system-design', 'complex-features', 'critical-decisions']
  }
};
```

## Implementation Roadmap

### **Week 1: Foundation**
- [ ] Initialize Task Master in core repositories (project-nexus, backend, sso_backend, accounts)
- [ ] Set up project-nexus as master coordinator
- [ ] Create cross-repository task templates
- [ ] Establish GitHub Actions for basic sync

### **Week 2: Integration**
- [ ] Implement cross-repository dependency tracking
- [ ] Set up Slack integration for notifications
- [ ] Create AI agent assignment protocols
- [ ] Establish automated task routing

### **Week 3: Automation**
- [ ] Deploy intelligent task creation from triggers (Sentry, CodeRabbit)
- [ ] Implement progress tracking dashboard
- [ ] Set up automated reporting
- [ ] Create conflict resolution mechanisms

### **Week 4: Optimization**
- [ ] Performance tuning and optimization
- [ ] Advanced analytics and predictions
- [ ] Custom workflow templates
- [ ] Documentation and training

## Practical Implementation Steps

### **Step 1: Execute Setup Script**
```bash
# Make the setup script executable and run it
chmod +x setup_cross_repo_taskmaster.sh
./setup_cross_repo_taskmaster.sh
```

### **Step 2: Initialize project-nexus as Master Coordinator**
```bash
cd ~/Desktop/Code/WeirdBrains/project-nexus
task-master init --name="project-nexus" --yes

# Copy the coordination config
cp ../cross_repo_coordination_config.json .taskmaster/
```

### **Step 3: Create Cross-Repository Tasks**
```bash
# In project-nexus repository
task-master add-task --prompt="Set up authentication flow across sso_backend, accounts, and mandible repositories with proper dependency tracking"

# Add cross-repository dependencies
task-master add-dependency --id=1 --depends-on="sso_backend.auth-api"
```

### **Step 4: Set up GitHub Actions for Sync**
Create `.github/workflows/taskmaster-sync.yml` in each repository:
```yaml
name: TaskMaster Sync
on:
  issues: [opened, closed, edited]
  pull_request: [opened, closed, merged]
jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Sync with TaskMaster
        run: |
          # Custom sync logic here
          echo "Syncing with TaskMaster..."
```

### **Step 5: Configure Slack Integration**
```bash
# Set up Slack webhook in each repository
export SLACK_WEBHOOK_URL="your-webhook-url"
task-master config --set slack.webhook=$SLACK_WEBHOOK_URL
```

## Generated Files

This analysis has created the following files for your implementation:

1. **`WeirdBrains_Repository_Analysis_and_TaskMaster_Coordination_Plan.md`** - This comprehensive analysis document
2. **`setup_cross_repo_taskmaster.sh`** - Automated setup script for all repositories
3. **`cross_repo_coordination_config.json`** - Master configuration for cross-repository coordination

## Next Steps

1. **Immediate Action Required**:
   - Run the setup script: `./setup_cross_repo_taskmaster.sh`
   - Review the generated status report
   - Initialize Task Master in any missing repositories

2. **Coordination Implementation**:
   - Set up project-nexus as master coordinator
   - Create cross-repository task templates
   - Implement GitHub Actions for automated sync
   - Configure Slack integration for notifications

3. **Advanced Integration**:
   - Set up Sentry integration for automated bug task creation
   - Configure CodeRabbit integration for code improvement tasks
   - Implement AI agent assignment protocols
   - Create progress tracking dashboard

This systematic approach will transform your development workflow into a cohesive, AI-assisted, multi-repository task management system that maintains your existing tools while adding powerful coordination and automation capabilities.
