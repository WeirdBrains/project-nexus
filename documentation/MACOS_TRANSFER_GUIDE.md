# 🍎 WeirdBrains macOS Transfer Guide

## 🎉 **Perfect Organization Complete!**

Your WeirdBrains project is now beautifully organized with a clean, logical structure that's ready for seamless macOS development.

## 📦 **What to Transfer**

Transfer the entire `WeirdBrains/` directory to your macOS machine. This single directory contains everything you need:

```
WeirdBrains/                    # 👈 Transfer this entire directory
├── repositories/               # All your Git repositories
├── workspaces/                # AI agent workspaces  
├── documentation/             # Complete setup guides
├── coordination/              # Project coordination
├── scripts/                   # Utility scripts
├── tasks/                     # Task Master files
├── tools/                     # Development tools
└── README.md                  # Project overview
```

## 🚀 **macOS Setup Steps**

### **1. Transfer Directory**
```bash
# Place the WeirdBrains directory at:
~/Desktop/Code/WeirdBrains/
```

### **2. Navigate to Project**
```bash
cd ~/Desktop/Code/WeirdBrains/
```

### **3. Check Repository Status**
```bash
# Verify all repositories are present
ls -la repositories/

# Check git status for each repository
for repo in repositories/*; do
    echo "=== $repo ==="
    git -C $repo status --porcelain
done
```

### **4. Set Up Development Environment**
```bash
# Switch all repositories to feature branch
for repo in repositories/*; do
    cd $repo
    git checkout -b feature/task-master-integration || git checkout feature/task-master-integration
    cd ..
done
```

### **5. Configure MCP Tools**
```bash
# Create MCP config directory
mkdir -p ~/.config/mcp/

# Copy MCP configuration from documentation/setup/macos/
# Update database connection strings for your macOS PostgreSQL
```

### **6. Initialize Task Master**
```bash
cd ~/Desktop/Code/WeirdBrains/
npx @taskmaster/cli init --project-root=$(pwd) --yes
npx @taskmaster/cli models --project-root=$(pwd) --set-main="claude-3-5-sonnet-20241022"
```

### **7. Verify Workspace Symlinks**
```bash
# Check mobile app workspace
ls -la workspaces/mobile-app/

# Check auth system workspace  
ls -la workspaces/auth-system/

# Check full stack workspace
ls -la workspaces/full-stack/
```

## 🤖 **Factory.ai Agent Setup**

### **Agent Workspace Paths**
- **Mobile App Agent:** `~/Desktop/Code/WeirdBrains/workspaces/mobile-app/`
- **Auth System Agent:** `~/Desktop/Code/WeirdBrains/workspaces/auth-system/`
- **Full Stack Agent:** `~/Desktop/Code/WeirdBrains/workspaces/full-stack/`
- **AI Pipeline Agent:** `~/Desktop/Code/WeirdBrains/workspaces/ai-pipeline/`

### **Factory.ai Connection Steps**
1. **Open Factory.ai** in your browser
2. **Click "Connect" → "Local Machine"**
3. **Install Factory Bridge** when prompted
4. **Grant file system permissions**
5. **Navigate agents** to the workspace paths above

### **Agent Prompts**

**Mobile App Agent:**
```
REPOSITORY ACCESS:
- Navigate to: ~/Desktop/Code/WeirdBrains/workspaces/mobile-app/
- Repositories: mandible, accounts (symlinked)
- Working branch: feature/task-master-integration

TASKS: Frontend development, UI/UX improvements, mobile optimization
```

**Auth System Agent:**
```
REPOSITORY ACCESS:
- Navigate to: ~/Desktop/Code/WeirdBrains/workspaces/auth-system/
- Repositories: sso_backend, accounts (symlinked)
- Working branch: feature/task-master-integration

TASKS: Authentication, SSO integration, user management
```

## 🔧 **Required API Keys**

Make sure you have these API keys ready:
- **Browserbase API Key** - For web automation testing
- **OneSignal API Key** - For push notifications
- **OpenAI/Anthropic API Keys** - For Task Master AI
- **Database credentials** - For PostgreSQL connections

## 📚 **Documentation Locations**

- **Complete Setup Guide:** `documentation/setup/macos/WeirdBrains-macOS-Setup.md`
- **Quick Reference:** `documentation/setup/macos/macOS-Quick-Reference.md`
- **Architecture Docs:** `documentation/architecture/`
- **Deployment Guide:** `documentation/deployment/`

## ✅ **Verification Checklist**

After setup, verify everything works:

```bash
# ✅ Check repository symlinks
ls -la repositories/

# ✅ Check workspace symlinks
ls -la workspaces/mobile-app/
ls -la workspaces/auth-system/

# ✅ Test Task Master
npx @taskmaster/cli get-tasks --project-root=$(pwd)

# ✅ Check git status all repos
for repo in repositories/*; do 
    echo "=== $repo ==="
    git -C $repo status --porcelain
done

# ✅ Verify MCP tools configuration
cat ~/.config/mcp/settings.json
```

## 🎯 **Benefits of This Organization**

1. **🧠 WeirdBrains First** - Clear brand identity and organization
2. **📁 Logical Structure** - Everything has its proper place
3. **🤖 AI Agent Ready** - Focused workspaces for each development area
4. **🔗 Symlink Magic** - No duplication, easy navigation
5. **📚 Complete Documentation** - All setup guides included
6. **🚀 Scalable** - Easy to add new repositories and workspaces

## 🔄 **What's Different from Before**

- **Top-level WeirdBrains** - No more confusing nested structures
- **Clean Repositories** - All repos in one organized location
- **Focused Workspaces** - Each AI agent has a dedicated workspace
- **Centralized Documentation** - Everything in one place
- **Integrated Tools** - OneSignal MCP, dental chatbot, etc.

---

## 🎉 **Ready to Rock on macOS!**

**Your WeirdBrains project is now perfectly organized and ready for seamless macOS development with Factory.ai agents!**

**📱 Simply transfer the `WeirdBrains/` directory and follow this guide to get started.**

---

**WeirdBrains - Revolutionizing Dental Practice Management** 🦷✨
