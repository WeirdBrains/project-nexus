# Task Master Migration Guide

## 🎯 Migration Overview

This guide provides step-by-step instructions for migrating Task Master from the current WeirdBrains root directory to the dedicated Project Nexus repository.

## 📋 Pre-Migration Checklist

### **Current State Verification**
```bash
# Verify current Task Master setup
cd /home/zack-mohorn/Desktop/Code/WeirdBrains
ls -la .taskmasterconfig tasks/ scripts/task-complexity-report.json

# Check current task status
cat tasks/tasks.json | jq '.[] | {id: .id, title: .title, status: .status}'

# Verify MCP tools functionality
# Test Task Master MCP tools are working
```

### **Backup Current State**
```bash
# Create backup of current Task Master data
mkdir -p backups/task-master-$(date +%Y%m%d)
cp -r tasks/ backups/task-master-$(date +%Y%m%d)/
cp .taskmasterconfig backups/task-master-$(date +%Y%m%d)/
cp scripts/task-complexity-report.json backups/task-master-$(date +%Y%m%d)/
```

## 🚀 Migration Process

### **Step 1: Prepare Project Nexus Repository**
```bash
# Ensure project-nexus is ready
cd project-nexus
git pull origin main

# Create Task Master directory structure
mkdir -p tasks scripts config

# Verify directory structure
ls -la
```

### **Step 2: Migrate Task Master Files**
```bash
# Copy task files
cp ../tasks/tasks.json tasks/
cp ../tasks/task_*.txt tasks/

# Copy configuration
cp ../.taskmasterconfig config/

# Copy scripts and reports
cp ../scripts/task-complexity-report.json scripts/

# Verify migration
ls -la tasks/ config/ scripts/
```

### **Step 3: Update Configuration Paths**
```bash
# Update .taskmasterconfig for new location
cd config
sed -i 's|/home/zack-mohorn/Desktop/Code/WeirdBrains|/home/zack-mohorn/Desktop/Code/WeirdBrains/project-nexus|g' .taskmasterconfig

# Verify configuration update
cat .taskmasterconfig
```

### **Step 4: Test Task Master MCP Tools**
```bash
# Test basic functionality
# Use Task Master MCP tools to verify:
# - get_tasks works with new location
# - task status updates function
# - complexity analysis accessible
```

## 🔧 Configuration Updates

### **Updated File Paths**
```json
// New Task Master configuration
{
  "projectRoot": "/home/zack-mohorn/Desktop/Code/WeirdBrains/project-nexus",
  "tasksFile": "tasks/tasks.json",
  "scriptsDir": "scripts/",
  "complexityReport": "scripts/task-complexity-report.json"
}
```

### **MCP Tools Configuration**
```bash
# Update MCP tools to use new project root
export TASKMASTER_PROJECT_ROOT="/home/zack-mohorn/Desktop/Code/WeirdBrains/project-nexus"

# Test MCP tools with new configuration
# Verify all Task Master MCP functions work correctly
```

## 📊 Post-Migration Validation

### **Functionality Testing**
```bash
# Test core Task Master functions
cd project-nexus

# 1. List all tasks
# Use get_tasks MCP tool

# 2. Get specific task details
# Use get_task MCP tool for task #13

# 3. Update task status
# Use set_task_status MCP tool

# 4. Check complexity analysis
# Use complexity_report MCP tool

# 5. Validate dependencies
# Use validate_dependencies MCP tool
```

### **Data Integrity Verification**
```bash
# Verify task count
cat tasks/tasks.json | jq '. | length'
# Should show 24 tasks

# Verify task structure
cat tasks/tasks.json | jq '.[0]' 
# Should show complete task structure

# Check for missing task files
for i in {1..24}; do
  if [ ! -f "tasks/task_$(printf "%03d" $i).txt" ]; then
    echo "Missing: task_$(printf "%03d" $i).txt"
  fi
done
```

## 🤖 AI Agent Integration Testing

### **Factory.ai Agent Testing**
```bash
# Test Factory.ai agent can access new location
# Agent should be able to:
# 1. Clone project-nexus repository
# 2. Read tasks/task_013.txt
# 3. Access task complexity information
# 4. Update task status via MCP tools
```

### **Augment Remote Agent Testing**
```bash
# Test Augment agent functionality
# Verify agent can:
# 1. Access project-nexus repository
# 2. Use Task Master MCP tools
# 3. Read and update task information
# 4. Generate complexity analysis
```

## 🔄 Rollback Procedure

### **If Migration Issues Occur**
```bash
# Restore from backup
cd /home/zack-mohorn/Desktop/Code/WeirdBrains
cp -r backups/task-master-$(date +%Y%m%d)/* .

# Restore original configuration
cp backups/task-master-$(date +%Y%m%d)/.taskmasterconfig .

# Reset MCP tools configuration
export TASKMASTER_PROJECT_ROOT="/home/zack-mohorn/Desktop/Code/WeirdBrains"

# Test original functionality
# Verify Task Master MCP tools work with original setup
```

## 📋 Migration Checklist

### **Pre-Migration**
- [ ] Backup current Task Master data
- [ ] Verify project-nexus repository is ready
- [ ] Test current Task Master MCP tools functionality
- [ ] Document current configuration

### **During Migration**
- [ ] Copy all task files to project-nexus/tasks/
- [ ] Copy configuration to project-nexus/config/
- [ ] Copy scripts to project-nexus/scripts/
- [ ] Update configuration file paths
- [ ] Test basic functionality

### **Post-Migration**
- [ ] Verify all 24 tasks migrated correctly
- [ ] Test Task Master MCP tools with new location
- [ ] Validate task complexity analysis
- [ ] Test dependency validation
- [ ] Verify AI agent access to new location

### **AI Agent Integration**
- [ ] Test Factory.ai agent repository access
- [ ] Test Augment remote agent functionality
- [ ] Verify MCP tools work for agents
- [ ] Test task assignment and status updates

## 🚨 Critical Success Factors

### **Data Integrity**
- **Zero Data Loss**: All 24 tasks and subtasks preserved
- **Configuration Accuracy**: All file paths updated correctly
- **MCP Tools Functionality**: All Task Master MCP tools working
- **Complexity Analysis**: Task complexity report accessible

### **AI Agent Compatibility**
- **Repository Access**: Agents can clone and access project-nexus
- **Task Reading**: Agents can read task files and complexity data
- **Status Updates**: Agents can update task status via MCP tools
- **Cross-Repository Coordination**: Task mapping works correctly

### **Performance Validation**
- **MCP Tools Response Time**: No degradation in tool performance
- **Task Query Speed**: Fast access to task information
- **Status Update Latency**: Real-time status updates working
- **Complexity Analysis**: Quick access to complexity reports

## 🎯 Success Metrics

### **Migration Success Criteria**
- **100% Data Migration**: All tasks, subtasks, and configuration migrated
- **Zero Downtime**: Task Master functionality maintained throughout
- **MCP Tools Compatibility**: All tools working with new location
- **AI Agent Integration**: Agents can access and use new setup

### **Performance Benchmarks**
- **Task Query Time**: <200ms for task list retrieval
- **Status Update Time**: <100ms for status changes
- **Complexity Analysis**: <500ms for complexity report generation
- **Agent Access Time**: <30 seconds for agent repository setup

---

**Next Steps After Migration**:
1. **Test AI Agent Integration**: Verify Factory.ai and Augment agents work with new setup
2. **Update Documentation**: Ensure all references point to new location
3. **Monitor Performance**: Track MCP tools performance with new configuration
4. **Begin Agent Coordination**: Start assigning tasks to AI agents

**Support**: For migration issues, refer to [Troubleshooting Guide](../05-reference/troubleshooting-guide.md)
