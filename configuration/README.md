# WeirdBrains Configuration Files

## 📁 Configuration Directory

This directory contains important configuration files that were centralized from the root WeirdBrains directory during the reorganization to the distributed repository structure.

## 📋 Configuration Files

### **`.taskmasterconfig`** - Task Master Configuration
- **Purpose**: Configuration for Task Master AI task management system
- **Contains**: Model settings, API configurations, global preferences
- **Usage**: Copy to individual repositories that use Task Master
- **Key Settings**:
  - Main model: Claude Sonnet 4
  - Research model: Perplexity Sonar Pro
  - Fallback model: Claude 3.7 Sonnet
  - Default subtasks: 5
  - Project name: Taskmaster

### **`.env.example`** - Environment Variables Template
- **Purpose**: Template for environment variables across WeirdBrains projects
- **Contains**: Example environment variable configurations
- **Usage**: Copy to individual repositories and rename to `.env`
- **Includes**: Logging, dependencies, editor settings

### **`.envrc`** - Directory Environment Configuration
- **Purpose**: Directory-specific environment configuration (direnv)
- **Contains**: Environment setup for development
- **Usage**: Used with direnv tool for automatic environment loading

### **`.gitignore`** - Git Ignore Rules
- **Purpose**: Standard Git ignore patterns for WeirdBrains projects
- **Contains**: Common ignore patterns for logs, dependencies, IDE files
- **Usage**: Copy to individual repositories as needed
- **Patterns**: 
  - Logs and debug files
  - Node modules
  - Environment files
  - IDE directories
  - OS-specific files
  - Task files

## 🚀 Usage Instructions

### **For Individual Repositories:**
1. **Copy relevant config files** to the repository root
2. **Customize** settings for the specific repository
3. **Add to .gitignore** if the file contains sensitive information

### **For macOS Setup:**
1. **project-nexus contains all configs** - clone it first
2. **Copy configs** to individual repositories as needed
3. **Update paths and settings** for macOS environment

### **For Task Master Setup:**
```bash
# Copy Task Master config to a repository
cp project-nexus/configuration/.taskmasterconfig ./

# Copy environment template
cp project-nexus/configuration/.env.example ./.env

# Copy gitignore patterns
cp project-nexus/configuration/.gitignore ./
```

## 🔧 Configuration Management

### **Centralized Benefits:**
- ✅ Single source of truth for configuration templates
- ✅ Consistent settings across all repositories
- ✅ Easy to update and maintain
- ✅ Version controlled in project-nexus

### **Distribution Strategy:**
- **Template Approach**: Use these as templates for individual repos
- **Customization**: Modify copies for repository-specific needs
- **Updates**: Update templates here, then propagate to repositories

## 📚 Related Documentation

- **Task Master Setup**: `../documentation/setup/`
- **Environment Configuration**: `../documentation/setup/macos/`
- **Repository Setup**: `../documentation/MACOS_CLONE_GUIDE.md`

## 🎯 Integration with Distributed Structure

These configuration files support the distributed repository approach by:

1. **Providing Templates**: Standard configurations for all repositories
2. **Maintaining Consistency**: Shared patterns and settings
3. **Enabling Coordination**: Task Master and environment setup
4. **Supporting macOS Transfer**: All configs available in project-nexus

---

**🎯 All WeirdBrains configuration templates are centralized here for easy distribution to individual repositories!**
