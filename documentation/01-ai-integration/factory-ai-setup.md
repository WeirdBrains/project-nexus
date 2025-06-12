# Factory.ai Agent Setup for Project Nexus

## 🎯 Overview

This guide provides step-by-step instructions for configuring Factory.ai agents to work with Project Nexus task management and cross-repository coordination.

## 📋 Prerequisites

- Factory.ai account with API access
- GitHub access to WeirdBrains organization repositories
- Understanding of Project Nexus task structure
- Access to development environment (localhost:8085/8080)

## 🚀 Quick Start for Factory.ai Agents

### **Step 1: Repository Setup**
```bash
# Clone Project Nexus (central coordination)
git clone https://github.com/WeirdBrains/project-nexus.git
cd project-nexus

# Review available tasks
ls tasks/
cat tasks/tasks.json | jq '.[] | select(.status == "pending")'
```

### **Step 2: Task Assignment Reading**
```bash
# Example: Read Backend API Optimization task
cat tasks/task_013.txt

# Key information to extract:
# - Task title and description
# - Repository mapping (backend)
# - Subtask breakdown
# - Dependencies and complexity
```

### **Step 3: Target Repository Setup**
```bash
# Clone target repository based on task mapping
git clone https://github.com/WeirdBrains/backend.git
cd backend

# Create feature branch
git checkout -b task-013-backend-api-optimization

# Review existing code structure
ls -la
cat README.md
```

## 🤖 Factory.ai Agent Configuration

### **Agent Types and Specializations**

#### **Code Droid - Primary Development Agent**
**Best for**: Backend APIs, payment integration, core feature development
**Target Tasks**: #13 (Backend API), #17 (Viral Waitlist), #22 (Stripe Integration)

```yaml
# Factory.ai Code Droid Configuration
agent_type: "code_droid"
specialization: "backend_development"
repositories:
  - "WeirdBrains/backend"
  - "WeirdBrains/sso_backend"
task_complexity_range: [7, 9]
testing_requirements:
  - "Run against mandible-dev database only"
  - "Include unit tests for new functionality"
  - "Verify API endpoint responses"
```

#### **Reliability Droid - Testing and Monitoring**
**Best for**: Error handling, monitoring, testing infrastructure
**Target Tasks**: #12 (Error Handling), #15 (Testing & Documentation)

```yaml
# Factory.ai Reliability Droid Configuration
agent_type: "reliability_droid"
specialization: "testing_monitoring"
repositories:
  - "WeirdBrains/backend"
  - "WeirdBrains/mandible"
task_complexity_range: [6, 8]
focus_areas:
  - "Error handling and recovery"
  - "Monitoring and alerting"
  - "Test coverage improvement"
```

#### **Knowledge Droid - Documentation**
**Best for**: Documentation generation, API documentation, guides
**Target Tasks**: Documentation updates, README improvements

```yaml
# Factory.ai Knowledge Droid Configuration
agent_type: "knowledge_droid"
specialization: "documentation"
repositories:
  - "WeirdBrains/project-nexus"
task_complexity_range: [5, 7]
output_formats:
  - "Markdown documentation"
  - "API documentation"
  - "Implementation guides"
```

## 📝 Task Execution Workflow

### **Standard Implementation Process**

#### **Phase 1: Task Analysis**
```bash
# 1. Read task file thoroughly
cat tasks/task_XXX.txt

# 2. Identify key requirements:
#    - Repository target
#    - Subtask breakdown
#    - Dependencies
#    - Testing requirements
#    - Acceptance criteria

# 3. Check task dependencies
grep -r "depends_on" tasks/task_XXX.txt
```

#### **Phase 2: Implementation Planning**
```bash
# 1. Review existing codebase
find . -name "*.dart" -o -name "*.js" -o -name "*.md" | head -20

# 2. Identify files to modify
# 3. Plan incremental commits (one per subtask)
# 4. Determine testing strategy
```

#### **Phase 3: Incremental Development**
```bash
# For each subtask:

# 1. Implement specific functionality
# 2. Run local tests
dart test  # For Dart projects
npm test   # For Node.js projects

# 3. Test against development database
# Use mandible-dev or sso-dev MCP tools

# 4. Commit with clear message
git add .
git commit -m "Task #13.1: Implement API endpoint optimization

- Add caching layer for frequently accessed data
- Optimize database queries with proper indexing
- Include performance metrics logging
- Add unit tests for new caching functionality

Testing: Verified against mandible-dev database
Performance: 40% improvement in response times"
```

#### **Phase 4: Pull Request Creation**
```bash
# 1. Push feature branch
git push origin task-013-backend-api-optimization

# 2. Create PR with specific format:
# Title: "Task #13: Backend API Optimization"
# Description template:
```

**Pull Request Template for Factory.ai Agents:**
```markdown
## Task #13: Backend API Optimization

### Implementation Summary
- ✅ Subtask 13.1: API endpoint caching implementation
- ✅ Subtask 13.2: Database query optimization
- ✅ Subtask 13.3: Performance metrics integration
- 🔄 Subtask 13.4: Load testing and validation

### Technical Changes
- Added Redis caching layer for API responses
- Optimized PostgreSQL queries with proper indexing
- Implemented performance monitoring middleware
- Added comprehensive unit test coverage

### Testing Results
- **Database**: Tested against mandible-dev only
- **Performance**: 40% improvement in API response times
- **Test Coverage**: 95% for new functionality
- **Backward Compatibility**: Verified with existing endpoints

### Dependencies
- Requires Redis installation (documented in README)
- Database migration included for new indexes
- No breaking changes to existing API contracts

### Next Steps
- Ready for human review and testing
- Deployment to staging environment recommended
- Monitor performance metrics post-deployment
```

## 🔧 Environment Configuration

### **Development Environment Setup**
```bash
# Backend development (localhost:8085)
cd backend
dart pub get
dart run bin/server.dart

# SSO backend development (localhost:8080)
cd sso_backend
dart pub get
dart run bin/server.dart

# Frontend development (for testing integration)
cd mandible
flutter pub get
flutter run -d web-server --web-port 3000
```

### **Database Access Configuration**
```bash
# Development databases only
export DB_HOST_DEV="mandible-dev-host"
export SSO_DB_HOST_DEV="sso-dev-host"

# NEVER use production databases for development
# Production access restricted to manual schema changes only
```

## 🚨 Critical Guidelines for Factory.ai Agents

### **Database Operations**
- ⚠️ **NEVER connect to production databases during development**
- ✅ **Use mandible-dev and sso-dev for all testing**
- ✅ **Include database migration scripts for schema changes**
- ✅ **Test all database operations thoroughly**

### **Code Quality Requirements**
- **Testing**: Include unit tests for all new functionality
- **Documentation**: Update relevant README and API docs
- **Performance**: Include performance metrics in PR description
- **Backward Compatibility**: Ensure no breaking changes

### **Security Considerations**
- **Credentials**: Never commit actual API keys or passwords
- **Environment Variables**: Use proper environment configuration
- **Access Control**: Respect existing permission structures
- **Data Protection**: Follow established data handling practices

## 📊 Performance Monitoring

### **Success Metrics for Factory.ai Agents**
- **Task Completion Rate**: Target 90%+ successful completion
- **Code Quality**: PR approval rate >90%
- **Testing Coverage**: Minimum 80% test coverage for new code
- **Performance Impact**: Document performance improvements/impacts

### **Reporting Template**
```markdown
## Factory.ai Agent Performance Report

**Task**: #13 - Backend API Optimization
**Agent**: Code Droid
**Duration**: 4 hours
**Status**: Completed

### Metrics
- **Subtasks Completed**: 8/9 (89%)
- **Test Coverage**: 95%
- **Performance Improvement**: 40% faster API responses
- **Code Quality Score**: A+ (automated analysis)

### Challenges Encountered
- Database connection configuration required manual adjustment
- Redis integration needed additional documentation

### Recommendations
- Pre-configure development environment templates
- Enhance database setup documentation
```

## 🔗 Integration with Project Nexus

### **Task Status Updates**
```bash
# Automatic status updates on PR merge
# Manual status updates during development
echo "Task #13 status: in-progress, 75% complete" >> task_status_log.txt
```

### **Cross-Repository Coordination**
- **Dependency Tracking**: Check dependent tasks before starting
- **Status Communication**: Update task status regularly
- **Conflict Resolution**: Report merge conflicts immediately
- **Documentation Updates**: Keep implementation docs current

---

**Next Steps**: 
1. Configure your Factory.ai agent with the appropriate specialization
2. Select a pending task from the task matrix
3. Follow the implementation workflow
4. Create PR using the provided template

**Support**: For issues or questions, refer to [Troubleshooting Guide](../05-reference/troubleshooting-guide.md)
