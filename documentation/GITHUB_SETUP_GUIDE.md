# 🐙 WeirdBrains GitHub Setup Guide

## 🎯 **Master Coordinator Strategy**

This guide sets up **project-nexus** as the master coordinator repository that orchestrates the entire WeirdBrains ecosystem on GitHub.

## 📋 **Step-by-Step GitHub Setup**

### **1. Create GitHub Organization**

```bash
# Go to GitHub and create organization: "WeirdBrains"
# https://github.com/organizations/new
```

### **2. Repository Creation Order**

Create repositories in this specific order to establish proper coordination:

```bash
# 1. Master Coordinator (FIRST)
WeirdBrains/project-nexus

# 2. Core Services (Foundation)
WeirdBrains/sso_backend
WeirdBrains/accounts

# 3. Main Application (Depends on core)
WeirdBrains/backend
WeirdBrains/mandible

# 4. Specialized Components
WeirdBrains/moire
WeirdBrains/infrastructure

# 5. Tools and Extensions
WeirdBrains/onesignal-mcp
WeirdBrains/dental-chatbot
WeirdBrains/sso_widgets
```

### **3. Initialize project-nexus as Master Coordinator**

```bash
# Navigate to project-nexus
cd WeirdBrains/repositories/project-nexus/

# Initialize as master coordinator
git init
git remote add origin https://github.com/WeirdBrains/project-nexus.git

# Set up master Task Master configuration
npx @taskmaster/cli init --project-root=$(pwd) --yes
npx @taskmaster/cli models --project-root=$(pwd) --set-main="claude-3-5-sonnet-20241022"

# Add all coordination files
git add .
git commit -m "Initialize project-nexus as master coordinator

- Add master coordination structure
- Configure AI agent assignments
- Set up repository dependencies
- Initialize Task Master as central hub"

# Push to GitHub
git branch -M main
git push -u origin main

# Create feature branch for current development
git checkout -b feature/task-master-integration
git push -u origin feature/task-master-integration
```

### **4. Set Up Other Repositories**

```bash
# For each repository, add project-nexus coordination
cd WeirdBrains/repositories/mandible/
git init
git remote add origin https://github.com/WeirdBrains/mandible.git

# Add reference to master coordinator
echo "# Coordinated by project-nexus" >> README.md
echo "Master coordination: https://github.com/WeirdBrains/project-nexus" >> README.md

git add .
git commit -m "Initial commit - coordinated by project-nexus"
git branch -M main
git push -u origin main
git checkout -b feature/task-master-integration
git push -u origin feature/task-master-integration

# Repeat for all repositories...
```

### **5. Configure Repository Settings**

For each repository in the WeirdBrains organization:

```yaml
# Repository Settings
Branch Protection Rules:
  main:
    - Require pull request reviews
    - Require status checks to pass
    - Require branches to be up to date
    - Include administrators
  
  feature/task-master-integration:
    - Allow force pushes (for development)
    - Require status checks to pass

# Repository Topics (for organization)
Topics: ["weirdbrains", "dental-practice", "flutter", "dart-frog"]

# Repository Description Templates
mandible: "WeirdBrains Flutter frontend - Dental practice management interface"
backend: "WeirdBrains main API backend - Core business logic and data management"
sso_backend: "WeirdBrains authentication service - Single sign-on and user management"
accounts: "WeirdBrains account management - User accounts and profile management"
project-nexus: "WeirdBrains master coordinator - Cross-repository orchestration and AI agent coordination"
moire: "WeirdBrains AI/ML components - Machine learning models and AI services"
infrastructure: "WeirdBrains infrastructure as code - Deployment and infrastructure management"
```

## 🤖 **AI Agent GitHub Integration**

### **Master Coordinator Agent Setup**

```bash
# Primary agent works directly with project-nexus
Agent Path: ~/Desktop/Code/WeirdBrains/repositories/project-nexus/
GitHub Integration: Direct push/pull to WeirdBrains/project-nexus
Branch Strategy: feature/task-master-integration → main

Responsibilities:
- Monitor all repository activity
- Coordinate cross-repo tasks
- Manage deployment sequences
- Update master documentation
- Distribute tasks to specialized agents
```

### **Specialized Agent GitHub Integration**

```bash
# Each specialized agent works through workspaces but reports to project-nexus
Frontend Agent:
  Workspace: ~/Desktop/Code/WeirdBrains/workspaces/mobile-app/
  Repositories: WeirdBrains/mandible, WeirdBrains/accounts
  Coordination: Through project-nexus master tasks

Backend Agent:
  Workspace: ~/Desktop/Code/WeirdBrains/workspaces/auth-system/
  Repositories: WeirdBrains/sso_backend, WeirdBrains/accounts
  Coordination: Through project-nexus master tasks

Full Stack Agent:
  Workspace: ~/Desktop/Code/WeirdBrains/workspaces/full-stack/
  Repositories: All WeirdBrains repositories
  Coordination: Through project-nexus master tasks
```

## 🔄 **Cross-Repository Coordination Workflow**

### **1. Task Creation and Distribution**
```bash
# Master coordinator creates tasks in project-nexus
cd ~/Desktop/Code/WeirdBrains/repositories/project-nexus/
npx @taskmaster/cli add-task --prompt="Implement user authentication flow"

# Task automatically distributed to appropriate agents based on:
# - Repository dependencies (coordination/repository-dependencies.json)
# - Agent assignments (coordination/ai-agent-assignments.json)
# - Workspace configurations
```

### **2. Cross-Repo Development**
```bash
# Agents work in their assigned workspaces
# All changes coordinated through project-nexus
# Master coordinator monitors progress across all repos
# Automatic synchronization of related tasks
```

### **3. Integration and Deployment**
```bash
# Master coordinator orchestrates deployment sequence
# Based on repository dependencies
# Automated testing across repository boundaries
# Coordinated deployment to production
```

## 📊 **GitHub Organization Benefits**

### **1. Centralized Coordination**
- **project-nexus** as single source of truth
- All repositories reference master coordinator
- Unified task management across all repos
- Coordinated AI agent development

### **2. Dependency Management**
- Clear repository dependencies defined
- Automated deployment sequencing
- Cross-repo integration testing
- Coordinated version management

### **3. AI Agent Orchestration**
- Master coordinator manages all agents
- Specialized agents focus on specific areas
- Cross-agent communication through project-nexus
- Unified progress tracking and reporting

### **4. Documentation Hub**
- All documentation centralized in project-nexus
- Cross-repository references and guides
- Unified setup and deployment instructions
- Single location for architecture documentation

## 🚀 **Deployment Strategy**

### **GitHub Actions Integration**
```yaml
# .github/workflows/coordinate-deployment.yml (in project-nexus)
name: Coordinate WeirdBrains Deployment
on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  coordinate-deployment:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout project-nexus
        uses: actions/checkout@v3
      
      - name: Check repository dependencies
        run: node scripts/check-dependencies.js
      
      - name: Trigger dependent deployments
        run: node scripts/trigger-deployments.js
      
      - name: Update coordination status
        run: node scripts/update-status.js
```

## 📋 **Next Steps**

1. **✅ Create GitHub organization "WeirdBrains"**
2. **✅ Set up project-nexus as master coordinator**
3. **✅ Initialize all repositories with coordination references**
4. **✅ Configure AI agents with GitHub integration**
5. **✅ Set up cross-repository workflows**
6. **✅ Test coordination and deployment sequences**

---

**GitHub Organization: WeirdBrains** 🧠  
**Master Coordinator: project-nexus** 🎯  
**AI Agent Orchestration: Enabled** 🤖
