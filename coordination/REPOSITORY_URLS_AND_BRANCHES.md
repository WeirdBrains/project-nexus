# WeirdBrains Repository URLs and Branches

## 📋 Repository Information for macOS Cloning

**Instructions**: Fill in the actual GitHub URLs and correct branch names for each repository.

### **Repository Details**

#### **project-nexus (Coordination Hub)**
- **GitHub URL**: `[UPDATE_WITH_ACTUAL_URL]`
- **Correct Branch**: `[UPDATE_WITH_CORRECT_BRANCH]`
- **Purpose**: Coordination hub with all documentation, tasks, and cross-repo coordination
- **Priority**: Clone FIRST - contains all coordination materials

#### **mandible (Flutter Frontend)**
- **GitHub URL**: `[UPDATE_WITH_ACTUAL_URL]`
- **Correct Branch**: `[UPDATE_WITH_CORRECT_BRANCH]`
- **Purpose**: Flutter web/mobile frontend application
- **Key Files**: pubspec.yaml, lib/, web/, android/, ios/

#### **backend (Main API Backend)**
- **GitHub URL**: `[UPDATE_WITH_ACTUAL_URL]`
- **Correct Branch**: `[UPDATE_WITH_CORRECT_BRANCH]`
- **Purpose**: Main Dart Frog API backend
- **Key Files**: pubspec.yaml, lib/, routes/, ddl.sql

#### **sso_backend (Authentication Service)**
- **GitHub URL**: `[UPDATE_WITH_ACTUAL_URL]`
- **Correct Branch**: `[UPDATE_WITH_CORRECT_BRANCH]`
- **Purpose**: SSO authentication service
- **Key Files**: pubspec.yaml, lib/, routes/, migrations/

#### **accounts (Account Management)**
- **GitHub URL**: `[UPDATE_WITH_ACTUAL_URL]`
- **Correct Branch**: `[UPDATE_WITH_CORRECT_BRANCH]`
- **Purpose**: Account management Flutter application
- **Key Files**: pubspec.yaml, lib/, web/, android/, ios/

#### **moire (AI/ML Components)**
- **GitHub URL**: `[UPDATE_WITH_ACTUAL_URL]`
- **Correct Branch**: `[UPDATE_WITH_CORRECT_BRANCH]`
- **Purpose**: AI/ML components and model development
- **Key Files**: flutter-sample-onnx-runtime/, model-development/

#### **infrastructure (Infrastructure as Code)**
- **GitHub URL**: `[UPDATE_WITH_ACTUAL_URL]`
- **Correct Branch**: `[UPDATE_WITH_CORRECT_BRANCH]`
- **Purpose**: Kubernetes configs and infrastructure automation
- **Key Files**: kubernetes/, nginx.conf

## 🔍 How to Find Repository Information

### **GitHub URLs**
1. Go to your GitHub organization: `https://github.com/WeirdBrains`
2. Find each repository listed above
3. Copy the clone URL (HTTPS or SSH)
4. Update the `[UPDATE_WITH_ACTUAL_URL]` placeholders

### **Correct Branches**
1. Check each repository's default branch (usually `main` or `master`)
2. Verify which branch has the latest stable code
3. For development, you might want `develop` or feature branches
4. Update the `[UPDATE_WITH_CORRECT_BRANCH]` placeholders

## 📝 Example Format

Once filled in, it should look like:

```markdown
#### **mandible (Flutter Frontend)**
- **GitHub URL**: `https://github.com/WeirdBrains/mandible.git`
- **Correct Branch**: `main`
- **Purpose**: Flutter web/mobile frontend application
- **Key Files**: pubspec.yaml, lib/, web/, android/, ios/
```

## 🚀 Quick Clone Script Template

Once you fill in the URLs and branches, you can create a script:

```bash
#!/bin/bash
# WeirdBrains Repository Cloning Script

mkdir -p ~/Desktop/Code/WeirdBrains
cd ~/Desktop/Code/WeirdBrains

# Clone project-nexus first
git clone [PROJECT_NEXUS_URL] project-nexus
cd project-nexus && git checkout [PROJECT_NEXUS_BRANCH] && cd ..

# Clone all other repositories
git clone [MANDIBLE_URL] mandible
cd mandible && git checkout [MANDIBLE_BRANCH] && cd ..

git clone [BACKEND_URL] backend
cd backend && git checkout [BACKEND_BRANCH] && cd ..

git clone [SSO_BACKEND_URL] sso_backend
cd sso_backend && git checkout [SSO_BACKEND_BRANCH] && cd ..

git clone [ACCOUNTS_URL] accounts
cd accounts && git checkout [ACCOUNTS_BRANCH] && cd ..

git clone [MOIRE_URL] moire
cd moire && git checkout [MOIRE_BRANCH] && cd ..

git clone [INFRASTRUCTURE_URL] infrastructure
cd infrastructure && git checkout [INFRASTRUCTURE_BRANCH] && cd ..

echo "✅ All repositories cloned successfully!"
```

## 📞 Next Steps

1. **Fill in this file** with actual URLs and branches
2. **Update** `MACOS_CLONE_GUIDE.md` with the same information
3. **Test** the cloning process on macOS
4. **Verify** all repositories are properly cloned and on correct branches

---

**🎯 This file serves as the single source of truth for repository information!**
