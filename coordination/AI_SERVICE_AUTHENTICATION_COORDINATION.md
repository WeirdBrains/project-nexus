# AI Service Authentication Fix - Cross-Repository Coordination

## 🚨 Critical Issue Overview

**Problem**: Users are being logged out when clicking the AI assistant button in the mandible Flutter app.

**Root Cause**: The `aiServiceProvider` uses the main `dioInstanceProvider` which contains WeirdBrains authentication interceptors. When AI service makes requests to DigitalOcean GenAI Platform, the interceptor error handling incorrectly clears user authentication state.

**Impact**: Blocking AI functionality and causing poor user experience.

## 📋 Task Coordination

### Primary Task
- **Mandible Repository**: Task #3 - "Create Isolated Dio Instance for AI Service Authentication"
- **Project-Nexus**: Task #11 - "Coordinate AI Service Authentication Fix Across Repositories"

### Cross-Repository Dependencies
```
mandible Task #3 (CRITICAL) → project-nexus Task #11 (COORDINATION)
                            ↓
backend (FUTURE) → sso_backend (FUTURE) → Enhanced AI Features
```

## 🏗️ Architecture Solution

### Phase 1: Immediate Fix (mandible)
```dart
// Current (BROKEN)
@riverpod
AIService aiService(Ref ref) {
  return AIService(dio: ref.read(dioInstanceProvider())); // Uses WeirdBrains auth
}

// Fixed (ISOLATED)
@riverpod
AIService aiService(Ref ref) {
  return AIService(dio: ref.read(aiDioInstanceProvider())); // Isolated instance
}
```

### Phase 2: Future Backend Integration
```dart
// Hybrid Architecture
@riverpod
AIService aiService(Ref ref) {
  return AIService(
    genaiDio: ref.read(aiDioInstanceProvider()),    // DigitalOcean GenAI
    backendDio: ref.read(dioInstanceProvider()),    // WeirdBrains backend
  );
}
```

## 🔄 Implementation Timeline

### Week 1: Critical Fix
- [ ] **mandible**: Implement isolated Dio instance (Task #3.1-3.4)
- [ ] **project-nexus**: Monitor progress and coordinate testing (Task #11.1)
- [ ] **Testing**: Verify authentication persistence

### Week 2: Architecture Preparation
- [ ] **backend**: Design AI case data endpoints (Task #11.2)
- [ ] **sso_backend**: Ensure auth compatibility (Task #11.2)
- [ ] **project-nexus**: Document architecture patterns (Task #11.3)

### Week 3: Integration Testing
- [ ] **All repos**: Cross-repository testing (Task #11.4)
- [ ] **project-nexus**: Coordinate deployment sequence (Task #11.4)
- [ ] **Documentation**: HIPAA compliance planning (Task #11.5)

## 🛡️ Security & Compliance

### HIPAA Requirements for Future Features
- **Data Encryption**: Case data must be encrypted before sending to DigitalOcean
- **Audit Logging**: Track all case data access for AI queries
- **User Consent**: Explicit consent for AI analysis of case data
- **Access Controls**: Role-based access to dental case information

### Authentication Isolation
```
DigitalOcean GenAI ←→ Isolated Dio Instance (No WeirdBrains auth)
WeirdBrains Backend ←→ Main Dio Instance (Full WeirdBrains auth)
```

## 📊 Repository Responsibilities

### mandible (Primary)
- **Immediate**: Fix logout bug with isolated Dio instance
- **Future**: Implement case-aware AI features
- **Testing**: Authentication persistence during AI calls

### backend (Secondary)
- **Future**: Design endpoints for AI case data integration
- **Security**: Implement HIPAA-compliant data encryption
- **API**: Provide structured case data for AI context

### sso_backend (Secondary)
- **Compatibility**: Ensure auth works with isolated AI service
- **Future**: Support dual authentication contexts
- **Security**: Maintain user session integrity

### project-nexus (Coordination)
- **Monitoring**: Track progress across all repositories
- **Documentation**: Maintain architecture documentation
- **Testing**: Coordinate cross-repository integration tests
- **Deployment**: Manage production deployment sequence

## 🧪 Testing Strategy

### Development Databases
- **mandible-dev**: Test AI service authentication
- **sso-dev**: Test authentication compatibility
- **Integration**: Cross-repository authentication flow

### Test Scenarios
1. **Authentication Persistence**: User remains logged in during AI calls
2. **Error Handling**: AI service errors don't affect main app auth
3. **Service Isolation**: DigitalOcean and WeirdBrains auth are independent
4. **Future Integration**: Mock backend data access for AI context

## 🚀 Deployment Sequence

### Production Deployment Order
1. **backend**: Deploy AI case data endpoints (when ready)
2. **sso_backend**: Deploy auth compatibility updates (when ready)
3. **mandible**: Deploy isolated Dio instance fix (immediate)

### Rollback Plan
- **mandible**: Revert to previous aiServiceProvider implementation
- **Monitoring**: Watch for authentication issues post-deployment
- **Hotfix**: Prepared rollback commits for immediate deployment

## 📞 Communication Plan

### Daily Standups
- **mandible team**: Progress on Task #3 subtasks
- **project-nexus**: Coordination blockers and dependencies
- **Cross-team**: Weekly sync on architecture preparation

### Documentation Updates
- **Real-time**: Update this coordination document with progress
- **Weekly**: Architecture documentation reviews
- **Milestone**: Cross-repository integration test results

## 🎯 Success Criteria

### Immediate (Week 1)
- [ ] Users can click AI assistant button without being logged out
- [ ] AI service functionality works with isolated authentication
- [ ] No regression in existing authentication flows

### Future (Weeks 2-3)
- [ ] Architecture prepared for backend integration
- [ ] HIPAA compliance plan documented and approved
- [ ] Cross-repository testing framework established
- [ ] Production deployment sequence validated

---

**Last Updated**: 2025-06-11  
**Coordinator**: Project-Nexus Task #11  
**Primary Implementation**: Mandible Task #3  
**Status**: In Progress - Critical Priority
