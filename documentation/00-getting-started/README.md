# Project Nexus Documentation

**AI-Powered Project Management and Cross-Repository Coordination System**

Welcome to Project Nexus - a comprehensive system for coordinating multi-agent development workflows across multiple repositories with AI automation.

## 🚀 Quick Start

### **For Human Developers**
1. **Clone Project Nexus**: `git clone https://github.com/WeirdBrains/project-nexus.git`
2. **Review Current Tasks**: Check `tasks/tasks.json` for active work
3. **Set Up Development Environment**: Follow [Development Setup Guide](../03-development-workflows/development-process.md)
4. **Configure AI Agents**: See [AI Integration Guide](../01-ai-integration/README.md)

### **For AI Agents (Factory.ai/Augment)**
1. **Clone Project Nexus**: `git clone https://github.com/WeirdBrains/project-nexus.git`
2. **Read Task Assignment**: Review `tasks/task_XXX.txt` for specific task details
3. **Clone Target Repository**: Based on task repository mapping below
4. **Follow Agent Workflow**: See [Agent Coordination Guide](../01-ai-integration/agent-coordination-workflows.md)

## 📋 Repository Mapping

| Task Range | Repository | Focus Area |
|------------|------------|------------|
| Tasks #1-12 | [WeirdBrains/mandible](https://github.com/WeirdBrains/mandible) | Flutter Frontend |
| Tasks #13-18 | [WeirdBrains/backend](https://github.com/WeirdBrains/backend) | Dart Frog Backend |
| Tasks #19-22 | [WeirdBrains/sso_backend](https://github.com/WeirdBrains/sso_backend) | SSO Backend |
| Tasks #23-24 | [WeirdBrains/accounts](https://github.com/WeirdBrains/accounts) | Account Management |

## 📚 Documentation Structure

### **🎯 Getting Started**
- **[Project Overview](project-overview.md)** - System architecture and goals
- **[Quick Start Guide](quick-start-guide.md)** - Immediate setup instructions
- **[Repository Structure](../04-system-architecture/repository-structure.md)** - Multi-repo organization

### **🤖 AI Integration**
- **[AI Integration Overview](../01-ai-integration/README.md)** - AI agent coordination system
- **[Factory.ai Setup](../01-ai-integration/factory-ai-setup.md)** - Factory.ai agent configuration
- **[Augment Agent Config](../01-ai-integration/augment-agent-config.md)** - Augment remote agent setup
- **[MCP Tools Integration](../01-ai-integration/mcp-tools-integration.md)** - Task Master and database MCP tools
- **[Agent Workflows](../01-ai-integration/agent-coordination-workflows.md)** - Multi-agent coordination patterns

### **📋 Task Management**
- **[Task Master Migration](../02-task-management/task-master-migration-guide.md)** - Migration from current setup
- **[Cross-Repo Coordination](../02-task-management/cross-repo-coordination.md)** - Multi-repository task management
- **[Complexity Analysis](../02-task-management/complexity-analysis.md)** - AI-powered task complexity scoring

### **⚙️ Development Workflows**
- **[Development Process](../03-development-workflows/development-process.md)** - Standard development workflow
- **[Deployment Automation](../03-development-workflows/deployment-automation.md)** - CI/CD and deployment coordination
- **[Testing Strategies](../03-development-workflows/testing-strategies.md)** - Testing across repositories

### **🏗️ System Architecture**
- **[Repository Structure](../04-system-architecture/repository-structure.md)** - Multi-repo organization
- **[Database Integration](../04-system-architecture/database-integration.md)** - MCP database tools and operations
- **[Infrastructure Overview](../04-system-architecture/infrastructure-overview.md)** - DigitalOcean and deployment infrastructure

### **📖 Reference**
- **[API Documentation](../05-reference/api-documentation.md)** - Project Nexus APIs
- **[Troubleshooting Guide](../05-reference/troubleshooting-guide.md)** - Common issues and solutions
- **[Legacy Documentation](../05-reference/legacy/)** - Archived documentation

## 🎯 Current Status

**Project Status**: 24 tasks total (2 completed, 4 in-progress, 18 pending)
**AI Integration**: Factory.ai and Augment agents ready for coordination
**Migration Status**: Task Master migration to Project Nexus in progress

## 🚨 Critical Information

### **For AI Agents - Task Assignment Process**
1. **Read Task Details**: Always start with `tasks/task_XXX.txt`
2. **Check Dependencies**: Verify prerequisite tasks are completed
3. **Clone Target Repo**: Use repository mapping above
4. **Create Feature Branch**: Follow naming convention `task-XXX-description`
5. **Implement & Test**: Follow subtask breakdown in task file
6. **Create Pull Request**: Include "Task #XXX" in PR title and description
7. **Update Status**: Report completion for tracking

### **Database Operations**
- **Development**: Use `mandible-dev` and `sso-dev` MCP tools
- **Production**: Use `mandible-prod` and `sso-prod` MCP tools (with extreme caution)
- **Schema Changes**: Always apply to production manually BEFORE merging backend code

### **Deployment Process**
- **Production Branch**: Pushing to `production` branch triggers automatic DigitalOcean deployment
- **Flutter Web**: Run `flutter build web` before merging to production
- **Environment URLs**: Development (localhost:8085/8080), Production (api.mandible.io/sso.weirdbrains.com)

## 🔗 Quick Links

- **[Current Tasks](../../tasks/tasks.json)** - Active task database
- **[Task Complexity Report](../../scripts/task-complexity-report.json)** - AI complexity analysis
- **[GitHub Organization](https://github.com/WeirdBrains)** - All repositories
- **[Production Deployment Guide](../PRODUCTION_DEPLOYMENT_GUIDE.md)** - Manual deployment procedures

## 🤝 Contributing

### **Human Developers**
- Create and update tasks using Task Master MCP tools
- Review AI agent pull requests
- Maintain repository-specific documentation
- Update task status as work progresses

### **AI Agents**
- Follow agent coordination workflows
- Create incremental commits per subtask
- Test against development databases only
- Maintain backward compatibility
- Include performance metrics in PR descriptions

---

**Next Steps**: Start with [Project Overview](project-overview.md) for system understanding, then proceed to [AI Integration](../01-ai-integration/README.md) for agent setup.
