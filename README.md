# project-nexus - WeirdBrains Coordination Hub

🎯 **Master Coordinator Repository** for the WeirdBrains ecosystem - your central hub for documentation, task management, and cross-repository coordination.

**📱 For macOS Setup**: This repository contains EVERYTHING you need for coordination. Clone this first, then use the guides here to clone all other repositories.

## 🏗️ What is project-nexus?

project-nexus serves as the **coordination hub** for all WeirdBrains repositories. It contains:

- 📚 **Complete Documentation** - All setup guides, architecture docs, and references
- 🎯 **Master Task Management** - Cross-repository task coordination and AI agent assignments
- 🤖 **AI Agent Orchestration** - Workflow management and agent coordination
- 🛠️ **Development Tools** - Scripts, utilities, and automation tools
- 📋 **Project Coordination** - Dependency management and release coordination

## 📁 Directory Structure

```
project-nexus/
├── documentation/          # 📚 Complete project documentation
│   ├── setup/             # Setup guides (Linux, macOS, etc.)
│   ├── architecture/      # System architecture and design
│   ├── api/               # API documentation and references
│   └── deployment/        # Deployment and production guides
├── coordination/          # 🎯 Cross-repo coordination
│   ├── ai-agent-assignments.json
│   ├── repository-dependencies.json
│   └── master-tasks.json
├── tasks/                 # 📋 Master Task Master files
│   ├── tasks.json         # Main task coordination file
│   └── task_*.txt         # Individual task files
└── scripts/               # 🛠️ Development utilities
    ├── cross-repo-task.sh
    └── sync-repositories.js
```

## 🚀 Quick Start

### **For macOS Setup:**
1. **Clone project-nexus first**: This repository contains all coordination materials
2. **Follow macOS Clone Guide**: See `documentation/MACOS_CLONE_GUIDE.md`
3. **Update Repository URLs**: Fill in `coordination/REPOSITORY_URLS_AND_BRANCHES.md`
4. **Clone All Repositories**: Use the guide to clone all WeirdBrains repositories

### **For Development:**
1. **Setup Development Environment**: See `documentation/setup/`
2. **Review Architecture**: Check `documentation/architecture/`
3. **Check Task Assignments**: Review `coordination/ai-agent-assignments.json`
4. **Run Coordination Scripts**: Use scripts in `scripts/`

## 🤖 AI Agent Coordination

AI agents coordinate through project-nexus while working in their respective repositories:

- **Mobile App Agent**: Works in `../mandible/`
- **Backend Agent**: Works in `../backend/` and `../sso_backend/`
- **Infrastructure Agent**: Works in `../infrastructure/`
- **AI Pipeline Agent**: Works in `../moire/`
- **Coordination Agent**: Works in `./` (this repository)

## 📖 Key Documentation Files

- **Setup Guides**: `documentation/setup/`
- **macOS Transfer**: `documentation/MACOS_TRANSFER_GUIDE.md`
- **GitHub Strategy**: `documentation/GITHUB_ORGANIZATION_STRATEGY.md`
- **Task Management**: `documentation/task-master-documentation-strategy.md`

## 🔗 Related Repositories

- [mandible](../mandible/) - Flutter frontend application
- [backend](../backend/) - Main API backend (Dart Frog)
- [sso_backend](../sso_backend/) - Authentication service
- [accounts](../accounts/) - Account management system
- [moire](../moire/) - AI/ML components
- [infrastructure](../infrastructure/) - Infrastructure as code

## 🎯 Task Management

Master task coordination is managed through:
- `tasks/tasks.json` - Main task file with cross-repo dependencies
- `coordination/master-tasks.json` - High-level task coordination
- `coordination/ai-agent-assignments.json` - AI agent task assignments

## 📞 Getting Help

All documentation is centralized here in project-nexus. Start with:
1. `documentation/setup/` for environment setup
2. `documentation/architecture/` for system understanding
3. `coordination/` for current project status and assignments

---

**🎯 project-nexus is your single source of truth for WeirdBrains coordination!**
