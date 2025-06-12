# WeirdBrains Project Organization Guide

## 📁 **Directory Structure Overview**

```
WeirdBrains/
├── WeirdBrains-v2/                    # Main organized structure
│   ├── repositories/                  # Git repositories
│   │   ├── mandible/                 # Flutter frontend (symlink)
│   │   ├── backend/                  # Main backend API (symlink)
│   │   ├── sso_backend/              # SSO authentication (symlink)
│   │   ├── accounts/                 # Account management (symlink)
│   │   └── project-nexus/            # Cross-repo coordination (symlink)
│   ├── workspaces/                   # AI agent workspaces (symlinks)
│   │   ├── mobile-app/               # Frontend development
│   │   ├── auth-system/              # Authentication system
│   │   ├── full-stack/               # Full-stack development
│   │   └── ai-pipeline/              # AI/ML development
│   ├── documentation/                # Centralized documentation
│   │   ├── setup/                    # Setup guides
│   │   │   ├── macos/               # macOS setup
│   │   │   ├── linux/               # Linux setup
│   │   │   ├── scripts/             # Setup scripts
│   │   │   └── configs/             # Configuration files
│   │   ├── architecture/             # System architecture docs
│   │   ├── api/                      # API documentation
│   │   └── deployment/               # Deployment guides
│   ├── coordination/                 # AI agent coordination
│   │   ├── agent-assignments.json   # Agent task assignments
│   │   └── project-nexus/           # Cross-repo coordination
│   └── scripts/                      # Utility scripts
│       ├── agents/                   # Agent management scripts
│       ├── migration/                # Migration scripts
│       └── development/              # Development utilities
├── [Original repositories]           # Original repo directories (to be cleaned)
├── tasks/                            # Task Master files
└── [Legacy files]                    # Files to be organized/cleaned
```

## 🎯 **Organization Principles**

### **1. Centralized Documentation**
- All documentation goes in `WeirdBrains-v2/documentation/`
- Setup guides organized by platform
- Architecture docs separate from implementation

### **2. Workspace-Based Development**
- AI agents work in focused workspaces
- Each workspace contains symlinks to relevant repositories
- Reduces context switching and improves focus

### **3. Repository Symlinks**
- Original repositories stay in place
- Symlinks in `repositories/` for organization
- Workspaces use symlinks to avoid duplication

### **4. Cross-Repository Coordination**
- `coordination/` directory manages multi-repo tasks
- Agent assignments tracked centrally
- Task Master integration for project management

## 🔧 **Setup Process**

### **Current Status**
- ✅ Directory structure created
- ✅ Workspaces configured
- ✅ Documentation structure established
- 🔄 **Next: Clean up legacy files**

### **Cleanup Tasks**
1. **Move documentation files** to proper locations
2. **Organize legacy directories** (WeirdBrains-Organized, mandible_app)
3. **Consolidate setup scripts** in scripts/
4. **Update symlinks** to point to original repositories
5. **Create macOS transfer package**

## 📋 **File Organization Plan**

### **Documentation to Move**
```bash
# Setup guides
./macOS-Quick-Reference.md → documentation/setup/macos/
./PRODUCTION_DEPLOYMENT_GUIDE.md → documentation/deployment/
./Implementation_Plan.md → documentation/architecture/

# Task Master files
./tasks/ → WeirdBrains-v2/tasks/
./taskmaster_setup_report.md → documentation/setup/

# Legacy coordination files
./mandible_app/coordination/ → coordination/legacy/
./project-nexus/ → repositories/project-nexus/
```

### **Scripts to Organize**
```bash
# Migration scripts
./WeirdBrains-v2/scripts/migrate-to-v2.sh → scripts/migration/
./mandible_app/migrate_to_feature_branches.sh → scripts/migration/

# Development scripts
./scripts/ → WeirdBrains-v2/scripts/development/
```

### **Repositories to Link**
```bash
# Create symlinks in repositories/
./mandible → WeirdBrains-v2/repositories/mandible
./backend → WeirdBrains-v2/repositories/backend
./sso_backend → WeirdBrains-v2/repositories/sso_backend
./accounts → WeirdBrains-v2/repositories/accounts
./project-nexus → WeirdBrains-v2/repositories/project-nexus
```

## 🚀 **Next Steps**

1. **Run organization script** to move files
2. **Update symlinks** to point to correct locations
3. **Test workspace functionality** with AI agents
4. **Create macOS transfer package**
5. **Clean up legacy directories**

## 📱 **macOS Transfer Ready**

Once organization is complete:
- `WeirdBrains-v2/` contains everything needed
- Documentation includes setup guides
- Scripts handle environment configuration
- Ready for Factory.ai agent setup

---

**Status: Organization in progress** 🔄
**Next: Execute cleanup and organization script**
