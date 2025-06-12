# WeirdBrains macOS Development Setup

## 🍎 Complete Transfer Guide from Linux to macOS

> **Note:** This file will be moved to `WeirdBrains-v2/documentation/` for proper organization

### **Directory Structure Setup**

```bash
# Create the main WeirdBrains-v2 structure on macOS
mkdir -p ~/Desktop/Code/WeirdBrains/WeirdBrains-v2/{repositories,workspaces,coordination}

# Navigate to the main directory
cd ~/Desktop/Code/WeirdBrains/WeirdBrains-v2
```

### **Repository Cloning**

```bash
# Clone all repositories
cd repositories/
git clone https://github.com/WeirdBrains/mandible.git
git clone https://github.com/WeirdBrains/backend.git
git clone https://github.com/WeirdBrains/sso_backend.git
git clone https://github.com/WeirdBrains/accounts.git
git clone https://github.com/WeirdBrains/project-nexus.git

# Switch all to feature branch
for repo in mandible backend sso_backend accounts project-nexus; do
    cd $repo
    git checkout -b feature/task-master-integration || git checkout feature/task-master-integration
    cd ..
done
```

### **Workspace Symlink Creation**

```bash
# Create workspace directories
cd ../workspaces/
mkdir -p {mobile-app,main-backend,auth-system,project-coordination}

# Mobile App Workspace
cd mobile-app/
ln -s ../../repositories/mandible ./mandible
ln -s ../../repositories/accounts ./accounts

# Main Backend Workspace  
cd ../main-backend/
ln -s ../../repositories/backend ./backend
ln -s ../../repositories/accounts ./accounts

# Auth System Workspace
cd ../auth-system/
ln -s ../../repositories/sso_backend ./sso_backend
ln -s ../../repositories/accounts ./accounts

# Project Coordination Workspace
cd ../project-coordination/
ln -s ../../repositories/project-nexus ./project-nexus
ln -s ../../repositories/mandible ./mandible
ln -s ../../repositories/backend ./backend
ln -s ../../repositories/sso_backend ./sso_backend
ln -s ../../repositories/accounts ./accounts
```

### **MCP Tools Configuration**

Create `~/.config/mcp/settings.json`:

```json
{
  "mcpServers": {
    "mandible-dev": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "postgresql://username:password@localhost:5432/mandible_dev"
      }
    },
    "mandible-prod": {
      "command": "npx", 
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "postgresql://username:password@localhost:5432/mandible_prod"
      }
    },
    "sso-dev": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"], 
      "env": {
        "POSTGRES_CONNECTION_STRING": "postgresql://username:password@localhost:5432/sso_dev"
      }
    },
    "sso-prod": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "postgresql://username:password@localhost:5432/sso_prod"
      }
    },
    "taskmaster-ai": {
      "command": "npx",
      "args": ["-y", "@taskmaster/mcp-server"],
      "env": {}
    },
    "browserbase": {
      "command": "npx",
      "args": ["-y", "@browserbase/mcp-server"],
      "env": {
        "BROWSERBASE_API_KEY": "your_browserbase_api_key"
      }
    },
    "onesignal": {
      "command": "npx", 
      "args": ["-y", "@onesignal/mcp-server"],
      "env": {
        "ONESIGNAL_API_KEY": "your_onesignal_api_key"
      }
    }
  }
}
```

### **Environment Configuration Files**

Create development environment switcher:

```bash
# Create Makefile in each repository
cat > Makefile << 'EOF'
.PHONY: run-dev run-prod

run-dev:
	@echo "Switching to development configuration..."
	@sed -i.bak "s|baseUrl: 'https://api.mandible.io'|baseUrl: 'http://localhost:8085'|g" lib/api/endpoints.dart
	@sed -i.bak "s|ssoUrl: 'https://sso.mandible.io'|ssoUrl: 'http://localhost:8080'|g" lib/services/sso.dart
	@echo "Development configuration active"

run-prod:
	@echo "Switching to production configuration..."
	@sed -i.bak "s|baseUrl: 'http://localhost:8085'|baseUrl: 'https://api.mandible.io'|g" lib/api/endpoints.dart
	@sed -i.bak "s|ssoUrl: 'http://localhost:8080'|ssoUrl: 'https://sso.mandible.io'|g" lib/services/sso.dart
	@echo "Production configuration active"
EOF
```

### **Task Master Integration**

```bash
# Initialize Task Master in project root
cd ~/Desktop/Code/WeirdBrains/WeirdBrains-v2/
npx @taskmaster/cli init --project-root=$(pwd) --yes

# Set up models (requires API keys)
npx @taskmaster/cli models --project-root=$(pwd) --set-main="claude-3-5-sonnet-20241022"
```

### **Factory.ai Agent Setup**

Factory.ai Connection Prompts:

**Backend Agent (Code Droid):**
```
REPOSITORY ACCESS:
- Navigate to: ~/Desktop/Code/WeirdBrains/WeirdBrains-v2/workspaces/auth-system/
- Repositories: sso_backend, accounts (symlinked)
- Working branch: feature/task-master-integration

TASKS: Cross-repository coordination, authentication, backend integration
```

**Frontend Agent (Reliability Droid):**
```
REPOSITORY ACCESS:
- Navigate to: ~/Desktop/Code/WeirdBrains/WeirdBrains-v2/workspaces/mobile-app/
- Repositories: mandible, accounts (symlinked)  
- Working branch: feature/task-master-integration

TASKS: Mobile app optimization, image processing, UI/UX improvements
```

### **Quick Setup Script**

Save as `setup-macos.sh`:

```bash
#!/bin/bash
echo "🍎 Setting up WeirdBrains on macOS..."

# Create directory structure
mkdir -p ~/Desktop/Code/WeirdBrains/WeirdBrains-v2/{repositories,workspaces,coordination}

# Clone repositories
cd ~/Desktop/Code/WeirdBrains/WeirdBrains-v2/repositories/
git clone https://github.com/WeirdBrains/mandible.git
git clone https://github.com/WeirdBrains/backend.git  
git clone https://github.com/WeirdBrains/sso_backend.git
git clone https://github.com/WeirdBrains/accounts.git
git clone https://github.com/WeirdBrains/project-nexus.git

# Create workspaces with symlinks
cd ../workspaces/
mkdir -p {mobile-app,main-backend,auth-system,project-coordination}

# Set up symlinks
cd mobile-app && ln -s ../../repositories/mandible . && ln -s ../../repositories/accounts .
cd ../main-backend && ln -s ../../repositories/backend . && ln -s ../../repositories/accounts .
cd ../auth-system && ln -s ../../repositories/sso_backend . && ln -s ../../repositories/accounts .
cd ../project-coordination && ln -s ../../repositories/project-nexus . && ln -s ../../repositories/mandible . && ln -s ../../repositories/backend . && ln -s ../../repositories/sso_backend . && ln -s ../../repositories/accounts .

echo "✅ WeirdBrains macOS setup complete!"
```

### **Database Connection Strings**

Update these in your MCP configuration:
- **Dev databases:** Point to your macOS PostgreSQL instance
- **Prod databases:** Keep same production connection strings
- **Ports:** Ensure 8080 (SSO) and 8085 (Backend) are available

### **API Keys to Transfer**

- Browserbase API Key
- OneSignal API Key  
- OpenAI/Anthropic API Keys for Task Master
- Database credentials

---

**Next Steps on macOS:**
1. Run `chmod +x setup-macos.sh && ./setup-macos.sh`
2. Configure MCP tools with your API keys
3. Initialize Task Master
4. Connect Factory.ai with Local Machine option
5. Start agents with the provided prompts
