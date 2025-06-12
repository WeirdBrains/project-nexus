# 🍎 WeirdBrains macOS Transfer Instructions

## 📦 **What to Transfer**

Transfer the entire `WeirdBrains-v2/` directory to your macOS machine. This contains everything you need:

```
WeirdBrains-v2/
├── documentation/          # All setup guides and docs
├── repositories/           # Repository symlinks (will need to be recreated)
├── workspaces/            # AI agent workspaces
├── coordination/          # Cross-repo coordination
├── tasks/                 # Task Master files
└── scripts/               # Utility scripts
```

## 🚀 **Quick macOS Setup**

### **1. Transfer the Directory**
```bash
# Copy WeirdBrains-v2/ to your macOS machine
# Place it at: ~/Desktop/Code/WeirdBrains/WeirdBrains-v2/
```

### **2. Run the macOS Setup**
```bash
cd ~/Desktop/Code/WeirdBrains/WeirdBrains-v2/
chmod +x scripts/organize-project.sh
./scripts/organize-project.sh
```

### **3. Clone Repositories**
```bash
cd repositories/
git clone https://github.com/WeirdBrains/mandible.git
git clone https://github.com/WeirdBrains/backend.git
git clone https://github.com/WeirdBrains/sso_backend.git
git clone https://github.com/WeirdBrains/accounts.git
git clone https://github.com/WeirdBrains/project-nexus.git

# Switch to feature branch
for repo in mandible backend sso_backend accounts project-nexus; do
    cd $repo
    git checkout -b feature/task-master-integration || git checkout feature/task-master-integration
    cd ..
done
```

### **4. Set Up MCP Tools**
```bash
# Create MCP config directory
mkdir -p ~/.config/mcp/

# Copy the MCP configuration from documentation/setup/macos/WeirdBrains-macOS-Setup.md
# Update database connection strings for your macOS PostgreSQL instance
```

### **5. Initialize Task Master**
```bash
cd ~/Desktop/Code/WeirdBrains/WeirdBrains-v2/
npx @taskmaster/cli init --project-root=$(pwd) --yes
npx @taskmaster/cli models --project-root=$(pwd) --set-main="claude-3-5-sonnet-20241022"
```

### **6. Connect Factory.ai Agents**

**Backend Agent Path:**
```
~/Desktop/Code/WeirdBrains/WeirdBrains-v2/workspaces/auth-system/
```

**Frontend Agent Path:**
```
~/Desktop/Code/WeirdBrains/WeirdBrains-v2/workspaces/mobile-app/
```

## 📋 **Essential Files Included**

### **Setup Documentation**
- `documentation/setup/macos/WeirdBrains-macOS-Setup.md` - Complete setup guide
- `documentation/setup/macos/macOS-Quick-Reference.md` - Quick reference
- `documentation/setup/taskmaster_setup_report.md` - Task Master setup

### **Architecture Documentation**
- `documentation/architecture/Implementation_Plan.md` - Project implementation plan
- `documentation/ORGANIZATION_GUIDE.md` - Project organization guide

### **Deployment Documentation**
- `documentation/deployment/PRODUCTION_DEPLOYMENT_GUIDE.md` - Production deployment

### **Task Management**
- `tasks/tasks.json` - All project tasks
- `tasks/task_*.txt` - Individual task files

### **Scripts**
- `scripts/organize-project.sh` - Project organization script
- `scripts/development/` - Development utilities
- `scripts/migration/` - Migration scripts

## 🔧 **API Keys Needed**

Make sure to have these API keys ready:
- **Browserbase API Key** - For web automation
- **OneSignal API Key** - For push notifications
- **OpenAI/Anthropic API Keys** - For Task Master AI
- **Database credentials** - For PostgreSQL connections

## ✅ **Verification Steps**

After setup, verify everything works:

```bash
# Check repository symlinks
ls -la repositories/

# Check workspace symlinks
ls -la workspaces/mobile-app/
ls -la workspaces/auth-system/

# Test Task Master
npx @taskmaster/cli get-tasks --project-root=$(pwd)

# Check git status
for repo in repositories/*; do 
    echo "=== $repo ==="
    git -C $repo status --porcelain
done
```

## 🤖 **Factory.ai Agent Setup**

1. **Open Factory.ai** in your browser
2. **Click "Connect" → "Local Machine"**
3. **Install Factory Bridge** when prompted
4. **Grant file system permissions**
5. **Navigate agents to workspace paths above**

## 📞 **Support**

If you encounter issues:
1. Check the detailed setup guide in `WeirdBrains-macOS-Setup.md`
2. Verify all symlinks are working
3. Ensure PostgreSQL is running on macOS
4. Check API key configuration

---

**Ready to transfer!** 🚀

Everything is organized and ready for seamless macOS development.
