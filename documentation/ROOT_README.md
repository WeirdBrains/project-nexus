# WeirdBrains - Distributed Repository Structure

Welcome to the WeirdBrains project ecosystem! This directory contains all the independent repositories that make up the WeirdBrains platform.

## 🏗️ Repository Structure

```
WeirdBrains/
├── project-nexus/          # 🎯 COORDINATION HUB - Start here!
├── mandible/              # 📱 Flutter frontend application
├── backend/               # 🔧 Main API backend (Dart Frog)
├── sso_backend/           # 🔐 Authentication service
├── accounts/              # 👥 Account management system
├── moire/                 # 🤖 AI/ML components
└── infrastructure/        # ☁️ Infrastructure as code
```

## 🚀 Getting Started

**👉 Start with [project-nexus](./project-nexus/)** - This is your coordination hub containing:

- 📚 **Complete Documentation** - Setup guides, architecture docs, API references
- 🎯 **Task Management** - Master Task Master configuration and cross-repo coordination
- 🤖 **AI Agent Coordination** - Agent assignments and workflow management
- 🛠️ **Scripts & Tools** - Development utilities and automation
- 📋 **Project Coordination** - Cross-repository dependency management

## 📖 Key Documentation

All documentation is centralized in `project-nexus/documentation/`:

- **Setup Guides**: `project-nexus/documentation/setup/`
- **Architecture**: `project-nexus/documentation/architecture/`
- **API Documentation**: `project-nexus/documentation/api/`
- **Deployment**: `project-nexus/documentation/deployment/`

## 🎯 Task Management

Master task coordination is managed in `project-nexus/tasks/` and `project-nexus/coordination/`.

## 🤖 AI Agent Workspaces

AI agents work directly in individual repositories while coordinating through project-nexus:

- **Mobile App Agent**: Works in `./mandible/`
- **Backend Agent**: Works in `./backend/` and `./sso_backend/`
- **Infrastructure Agent**: Works in `./infrastructure/`
- **AI Pipeline Agent**: Works in `./moire/`
- **Coordination Agent**: Works in `./project-nexus/`

## 🔗 Repository Independence

Each repository is:
- ✅ **Independently shareable** - Can be cloned/shared separately
- ✅ **Self-contained** - Has its own Git history and dependencies
- ✅ **Focused** - Single responsibility and clear boundaries
- ✅ **Coordinated** - Managed through project-nexus for cross-repo tasks

## 📞 Support

For questions, issues, or coordination needs, check the documentation in `project-nexus/` or refer to the coordination files in `project-nexus/coordination/`.

---

**🎯 Remember: Always start with [project-nexus](./project-nexus/) for the complete picture!**
