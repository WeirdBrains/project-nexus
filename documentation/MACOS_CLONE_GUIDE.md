# macOS Repository Cloning Guide

## 🎯 Overview

This guide provides the exact commands to clone all WeirdBrains repositories with the correct branches on macOS, creating the distributed repository structure.

## 📁 Target Directory Structure

```
WeirdBrains/                    # Create this directory on macOS
├── project-nexus/             # Clone first - contains all coordination
├── mandible/                  # Flutter frontend
├── backend/                   # Main API backend
├── sso_backend/              # Authentication service
├── accounts/                 # Account management
├── moire/                    # AI/ML components
└── infrastructure/           # Infrastructure as code
```

## 🚀 Step-by-Step Cloning Instructions

### **Step 1: Create Base Directory**
```bash
mkdir -p ~/Desktop/Code/WeirdBrains
cd ~/Desktop/Code/WeirdBrains
```

### **Step 2: Clone project-nexus First (Coordination Hub)**
```bash
# Clone project-nexus - contains all documentation and coordination
git clone [PROJECT_NEXUS_REPO_URL] project-nexus
cd project-nexus
git checkout [CORRECT_BRANCH]  # Update with correct branch
cd ..
```

### **Step 3: Clone All Other Repositories**

#### **mandible (Flutter Frontend)**
```bash
git clone [MANDIBLE_REPO_URL] mandible
cd mandible
git checkout [CORRECT_BRANCH]  # Update with correct branch
cd ..
```

#### **backend (Main API Backend)**
```bash
git clone [BACKEND_REPO_URL] backend
cd backend
git checkout [CORRECT_BRANCH]  # Update with correct branch
cd ..
```

#### **sso_backend (Authentication Service)**
```bash
git clone [SSO_BACKEND_REPO_URL] sso_backend
cd sso_backend
git checkout [CORRECT_BRANCH]  # Update with correct branch
cd ..
```

#### **accounts (Account Management)**
```bash
git clone [ACCOUNTS_REPO_URL] accounts
cd accounts
git checkout [CORRECT_BRANCH]  # Update with correct branch
cd ..
```

#### **moire (AI/ML Components)**
```bash
git clone [MOIRE_REPO_URL] moire
cd moire
git checkout [CORRECT_BRANCH]  # Update with correct branch
cd ..
```

#### **infrastructure (Infrastructure as Code)**
```bash
git clone [INFRASTRUCTURE_REPO_URL] infrastructure
cd infrastructure
git checkout [CORRECT_BRANCH]  # Update with correct branch
cd ..
```

## 📋 Repository Information Needed

**Please update this section with the actual repository URLs and branches:**

| Repository | GitHub URL | Correct Branch | Notes |
|------------|------------|----------------|-------|
| project-nexus | `[UPDATE_URL]` | `[UPDATE_BRANCH]` | Coordination hub |
| mandible | `[UPDATE_URL]` | `[UPDATE_BRANCH]` | Flutter frontend |
| backend | `[UPDATE_URL]` | `[UPDATE_BRANCH]` | Main API backend |
| sso_backend | `[UPDATE_URL]` | `[UPDATE_BRANCH]` | Authentication |
| accounts | `[UPDATE_URL]` | `[UPDATE_BRANCH]` | Account management |
| moire | `[UPDATE_URL]` | `[UPDATE_BRANCH]` | AI/ML components |
| infrastructure | `[UPDATE_URL]` | `[UPDATE_BRANCH]` | Infrastructure |

## ✅ Verification Steps

After cloning all repositories, verify the structure:

```bash
cd ~/Desktop/Code/WeirdBrains
ls -la
# Should show: project-nexus/ mandible/ backend/ sso_backend/ accounts/ moire/ infrastructure/

# Verify each repository has content
for repo in project-nexus mandible backend sso_backend accounts moire infrastructure; do
  echo "=== $repo ==="
  ls $repo | head -5
done
```

## 🎯 Post-Clone Setup

### **1. Review Coordination Hub**
```bash
cd project-nexus
cat README.md
# Review all documentation in documentation/
```

### **2. Check Development Environment Setup**
```bash
# Follow setup guides in project-nexus/documentation/setup/macos/
cd project-nexus/documentation/setup/macos/
ls -la
```

### **3. Verify Git Status**
```bash
# Check all repositories are on correct branches
for repo in project-nexus mandible backend sso_backend accounts moire infrastructure; do
  echo "=== $repo ==="
  cd $repo && git branch && git status --porcelain | head -3 && cd ..
done
```

## 🤖 AI Agent Configuration

After cloning, AI agents can work in their focused repositories:

- **Mobile App Agent**: `~/Desktop/Code/WeirdBrains/mandible/`
- **Backend Agent**: `~/Desktop/Code/WeirdBrains/backend/` + `~/Desktop/Code/WeirdBrains/sso_backend/`
- **Infrastructure Agent**: `~/Desktop/Code/WeirdBrains/infrastructure/`
- **AI Pipeline Agent**: `~/Desktop/Code/WeirdBrains/moire/`
- **Coordination Agent**: `~/Desktop/Code/WeirdBrains/project-nexus/`

All coordination happens through `project-nexus/coordination/` files.

## 📚 Documentation Access

All documentation is centralized in `project-nexus/documentation/`:
- **Setup Guides**: `setup/macos/`
- **Architecture**: `architecture/`
- **API Documentation**: `api/`
- **Deployment**: `deployment/`

## 🔧 Development Environment

Each repository is self-contained:
- **Flutter Projects**: `mandible/`, `accounts/` (run `flutter pub get`)
- **Dart Frog Backends**: `backend/`, `sso_backend/` (run `dart pub get`)
- **AI/ML**: `moire/` (follow specific setup in repo)
- **Infrastructure**: `infrastructure/` (Kubernetes configs)

## 📞 Support

- **Start Here**: `project-nexus/README.md`
- **Setup Issues**: `project-nexus/documentation/setup/macos/`
- **Coordination**: `project-nexus/coordination/`

---

**🎯 This guide ensures you get the exact distributed structure with all coordination materials in project-nexus!**
