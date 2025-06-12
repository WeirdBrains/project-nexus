# WeirdBrains Directory Reorganization Plan

## 🎯 **New Organized Structure**

```
/home/zack-mohorn/Desktop/Code/WeirdBrains/
├── 🎯 coordination/                    # Master coordination hub
│   ├── project-nexus/                  # Task management & cross-repo coordination
│   ├── scripts/                        # Shared automation scripts
│   ├── documentation/                  # Team guides & onboarding
│   └── reports/                        # Generated status reports
│
├── 🎮 frontend/                        # All frontend applications
│   ├── mandible/                       # Main Flutter app (moved from mandible_app/mandible)
│   ├── accounts/                       # SSO frontend interface
│   └── sso_widgets/                    # Shared UI components
│
├── 🔧 backend/                         # All backend services
│   ├── api/                           # Main API service (renamed from 'backend')
│   ├── sso/                           # Authentication service (renamed from 'sso_backend')
│   └── shared/                        # Shared backend utilities
│
├── 🤖 ai-services/                     # AI/ML services
│   ├── moire/                         # Image processing & AI models
│   ├── dental-chatbot/                # Dental AI assistant
│   └── onesignal-mcp/                 # Push notification service
│
├── 🏗️ infrastructure/                  # DevOps & deployment
│   ├── kubernetes/                     # K8s configurations
│   ├── deployment/                     # Deploy scripts & configs
│   └── monitoring/                     # Health checks & monitoring
│
└── 📚 shared/                          # Shared resources
    ├── docs/                          # Project-wide documentation
    ├── assets/                        # Shared assets & resources
    └── templates/                     # Code templates & examples
```

## 🧠 **AI Agent Optimization**

### **Context Window Strategy:**
- **Small Context Agents**: Work within specific service directories
- **Large Context Agent**: Coordinates across all directories from `coordination/`

### **Agent Assignment:**
```
frontend/mandible/          → flutter-agent (UI/UX, mobile development)
backend/api/               → api-agent (REST APIs, business logic)
backend/sso/               → auth-agent (Authentication, security)
ai-services/moire/         → ml-agent (AI/ML, image processing)
ai-services/dental-chatbot/ → chatbot-agent (Conversational AI)
coordination/project-nexus/ → coordination-agent (Cross-repo management)
```

## 🔄 **Safe Migration Steps**

### **Phase 1: Create New Structure (No Disruption)**
```bash
# Create new directory structure
mkdir -p coordination/{project-nexus,scripts,documentation,reports}
mkdir -p frontend/{mandible,accounts,sso_widgets}
mkdir -p backend/{api,sso,shared}
mkdir -p ai-services/{moire,dental-chatbot,onesignal-mcp}
mkdir -p infrastructure/{kubernetes,deployment,monitoring}
mkdir -p shared/{docs,assets,templates}
```

### **Phase 2: Copy & Test (Keep Originals)**
```bash
# Copy repositories to new locations (test first)
cp -r mandible_app/mandible/ frontend/mandible/
cp -r backend/ backend/api/
cp -r sso_backend/ backend/sso/
cp -r accounts/ frontend/accounts/
cp -r moire/ ai-services/moire/
cp -r project-nexus/ coordination/project-nexus/
```

### **Phase 3: Update Scripts & Configs**
```bash
# Update cross-repo-task.sh paths
# Update Task Master configurations
# Update CI/CD paths
# Update documentation links
```

### **Phase 4: Validate & Switch (When Ready)**
```bash
# Test all functionality with new paths
# Update team documentation
# Switch development to new structure
# Archive old structure
```

## 📊 **Benefits of New Structure**

### **For Development:**
- **Logical grouping**: Related services are co-located
- **Clear separation**: Frontend, backend, AI services, infrastructure
- **Scalable**: Easy to add new services in appropriate categories
- **Professional**: Industry-standard organization

### **For AI Agents:**
- **Reduced context**: Agents only see relevant files
- **Clear scope**: Each agent knows their domain
- **Predictable paths**: Standard naming conventions
- **Efficient coordination**: Central coordination hub

### **For Team:**
- **Intuitive navigation**: Easy to find what you need
- **Clear ownership**: Each directory has a clear purpose
- **Better onboarding**: New team members understand structure quickly
- **Maintainable**: Easier to manage as project grows

## 🛡️ **Safety Measures**

### **Migration Safety:**
1. **Copy, don't move** initially
2. **Test thoroughly** before switching
3. **Keep backups** of original structure
4. **Gradual transition** - one service at a time
5. **Team communication** before major changes

### **Development Continuity:**
- **No disruption** to current mandible development
- **Parallel testing** of new structure
- **Rollback plan** if issues arise
- **Documentation updates** throughout process

## 🎯 **Immediate Next Steps**

1. **Create new directory structure** (5 minutes)
2. **Copy coordination files** to test new layout
3. **Update cross-repo scripts** to use new paths
4. **Test functionality** with new structure
5. **Get your approval** before major migration

Would you like me to proceed with Phase 1 (creating the new structure) to test it out?
