# 🍎 WeirdBrains macOS Quick Reference

## **Essential Directory Structure**
```
~/Desktop/Code/WeirdBrains/WeirdBrains-v2/
├── repositories/          # Git repositories
│   ├── mandible/
│   ├── backend/
│   ├── sso_backend/
│   ├── accounts/
│   └── project-nexus/
├── workspaces/           # Symlink collections for AI agents
│   ├── mobile-app/       # mandible + accounts
│   ├── main-backend/     # backend + accounts  
│   ├── auth-system/      # sso_backend + accounts
│   └── project-coordination/  # all repos
└── coordination/         # AI agent management
```

## **One-Line Setup**
```bash
curl -O https://raw.githubusercontent.com/WeirdBrains/setup/main/setup-macos.sh && chmod +x setup-macos.sh && ./setup-macos.sh
```

## **MCP Tools Config Location**
```bash
~/.config/mcp/settings.json
```

## **Key Environment Variables**
```bash
# Development
MANDIBLE_API_URL=http://localhost:8085
SSO_API_URL=http://localhost:8080

# Production  
MANDIBLE_API_URL=https://api.mandible.io
SSO_API_URL=https://sso.mandible.io
```

## **Factory.ai Agent Paths**
- **Backend Agent:** `~/Desktop/Code/WeirdBrains/WeirdBrains-v2/workspaces/auth-system/`
- **Frontend Agent:** `~/Desktop/Code/WeirdBrains/WeirdBrains-v2/workspaces/mobile-app/`

## **Task Master Commands**
```bash
# Initialize
npx @taskmaster/cli init --project-root=$(pwd) --yes

# Set model
npx @taskmaster/cli models --project-root=$(pwd) --set-main="claude-3-5-sonnet-20241022"

# Get tasks
npx @taskmaster/cli get-tasks --project-root=$(pwd)
```

## **Git Branch Strategy**
- **Working branch:** `feature/task-master-integration`
- **All repos use same branch** for coordination

## **Database Ports**
- **Backend:** 8085
- **SSO:** 8080
- **PostgreSQL:** 5432

## **API Keys Needed**
- Browserbase API Key
- OneSignal API Key
- OpenAI/Anthropic API Keys
- Database credentials

## **Quick Commands**
```bash
# Switch to dev
make run-dev

# Switch to prod  
make run-prod

# Check git status all repos
for repo in repositories/*; do echo "=== $repo ==="; git -C $repo status --porcelain; done

# Start all services
cd workspaces/main-backend/backend && dart_frog dev &
cd workspaces/auth-system/sso_backend && dart_frog dev --port 8080 &
```

## **Factory.ai Connection**
1. Click "Connect" → "Local Machine"
2. Install Factory Bridge
3. Grant file system permissions
4. Use workspace paths above for agents
