# DA-3 Dental Chatbot Backend Migration Coordination

## Overview

This document coordinates the migration of DA-3 dental chatbot functionality from the WeirdBrains/mandible Flutter frontend to the WeirdBrains/backend (Dart Frog) across all repositories in the WeirdBrains ecosystem.

**Task Master Reference:** Task #12 in project-nexus
**Dependencies:** Task #11 (AI Service Authentication Fix)
**Priority:** High
**Status:** Pending

## Cross-Repository Coordination

### Repositories Involved

1. **WeirdBrains/backend** - Primary implementation repository
2. **WeirdBrains/mandible** - Frontend migration and integration
3. **WeirdBrains/project-nexus** - Master coordination and documentation
4. **WeirdBrains/sso_backend** - Authentication integration (if needed)

### Implementation Phases

#### Phase 1: Backend AI Service Infrastructure
**Repository:** WeirdBrains/backend
**Task Master Subtask:** 12.1

**Deliverables:**
- AI Service class (`lib/services/ai_service.dart`)
- Environment configuration updates (`lib/env.dart`)
- DigitalOcean GenAI Platform integration
- HTTP client setup with proper timeout and retry logic

**Coordination Points:**
- Ensure environment variables align with mandible configuration
- Coordinate API key management with security team
- Document service architecture for frontend team

#### Phase 2: API Endpoints Development
**Repository:** WeirdBrains/backend
**Task Master Subtask:** 12.2

**Deliverables:**
- Chat session endpoints (`routes/ai/chat/sessions/`)
- Message endpoints (`routes/ai/chat/messages/`)
- Health check endpoint (`routes/ai/health.dart`)
- Database schema migrations

**API Endpoints:**
```
POST   /ai/chat/sessions          - Create new chat session
GET    /ai/chat/sessions          - List user's chat sessions
GET    /ai/chat/sessions/{id}     - Get session details
DELETE /ai/chat/sessions/{id}     - Delete session

POST   /ai/chat/messages          - Send message to AI
GET    /ai/chat/messages          - Get chat history
GET    /ai/chat/messages/{id}     - Get specific message
POST   /ai/chat/messages/{id}/regenerate - Regenerate AI response

GET    /ai/health                 - Check AI service status
```

**Database Schema:**
```sql
-- ai_chat_sessions table
CREATE TABLE ai_chat_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    title VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    status VARCHAR(50) DEFAULT 'active'
);

-- ai_messages table
CREATE TABLE ai_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID NOT NULL REFERENCES ai_chat_sessions(id),
    role VARCHAR(20) NOT NULL, -- 'user' or 'assistant'
    content TEXT NOT NULL,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ai_audit_logs table (HIPAA compliance)
CREATE TABLE ai_audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID REFERENCES ai_chat_sessions(id),
    user_id UUID NOT NULL REFERENCES users(id),
    action VARCHAR(100) NOT NULL,
    details JSONB,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);
```

**Coordination Points:**
- API design review with frontend team
- Database migration coordination with DevOps
- Authentication middleware integration with SSO team

#### Phase 3: Frontend Migration
**Repository:** WeirdBrains/mandible
**Task Master Subtask:** 12.3

**Deliverables:**
- Updated `AIService` class to use backend APIs
- Modified `DA3ChatController` for backend integration
- Removed local storage dependencies
- Environment configuration updates
- Feature flag implementation

**Files to Modify:**
- `lib/services/ai_service.dart`
- `lib/views/da3_chat/controller/da3_chat_controller.dart`
- `lib/config/env_config.dart`
- `lib/api/endpoints.dart`

**Coordination Points:**
- API endpoint testing with backend team
- Feature flag coordination for gradual rollout
- User experience validation during migration

#### Phase 4: Security & Compliance
**Repository:** Cross-repository
**Task Master Subtask:** 12.4

**Deliverables:**
- Centralized authentication verification
- PHI encryption implementation
- Comprehensive audit logging
- HIPAA compliance documentation

**Security Measures:**
- API keys never exposed to frontend
- All PHI encrypted at rest and in transit
- Comprehensive audit trail for all AI interactions
- Role-based access controls
- Rate limiting and quota management

**Coordination Points:**
- Security review across all repositories
- Compliance verification with legal team
- Penetration testing coordination

#### Phase 5: Performance & Monitoring
**Repository:** Cross-repository
**Task Master Subtask:** 12.5

**Deliverables:**
- Monitoring and alerting setup
- Performance optimization
- Cost tracking implementation
- Rollback procedures

**Monitoring Metrics:**
- AI service response times
- Error rates and types
- Usage patterns and costs
- Database performance
- User satisfaction metrics

**Coordination Points:**
- DevOps team for monitoring setup
- Cost management with finance team
- Performance benchmarking across environments

## Migration Strategy

### Hybrid Approach

1. **Phase 1-2**: Backend development and testing
2. **Phase 3**: Frontend integration with feature flags
3. **Phase 4-5**: Gradual rollout with monitoring

### Feature Flag Implementation

```dart
// Environment configuration
static bool get useBackendAI => _getEnvVariable(
  'USE_BACKEND_AI',
  defaultValue: 'false',
).toLowerCase() == 'true';

// Service selection
final aiService = useBackendAI 
  ? BackendAIService(dio: dio)
  : DirectAIService(dio: dio);
```

### Rollout Plan

1. **Internal Testing** (0% users) - Development team only
2. **Beta Testing** (5% users) - Selected beta testers
3. **Gradual Rollout** (25%, 50%, 75%) - Phased user migration
4. **Full Deployment** (100% users) - Complete migration

## Risk Mitigation

### Technical Risks

1. **Increased Latency**
   - Mitigation: Response streaming, WebSocket connections
   - Monitoring: Response time alerts

2. **Backend Service Reliability**
   - Mitigation: Circuit breaker pattern, fallback to frontend
   - Monitoring: Health checks and auto-scaling

3. **Data Migration Issues**
   - Mitigation: Export/import tools, backward compatibility
   - Monitoring: Data integrity checks

### Operational Risks

1. **Deployment Complexity**
   - Mitigation: Feature flags, gradual rollout
   - Monitoring: Deployment success metrics

2. **User Experience Degradation**
   - Mitigation: Performance optimization, user feedback
   - Monitoring: User satisfaction surveys

## Success Metrics

### Technical Metrics
- API response time < 2 seconds (95th percentile)
- Error rate < 1%
- 99.9% uptime for AI services
- Zero security incidents

### Business Metrics
- User satisfaction maintained or improved
- Cost reduction through optimized API usage
- Improved HIPAA compliance score
- Faster feature development velocity

## Communication Plan

### Stakeholders
- Development teams (backend, frontend, DevOps)
- Product management
- Security and compliance teams
- End users (dental professionals)

### Communication Channels
- Weekly progress updates in project-nexus
- Slack notifications for milestone completion
- Email updates for major phase transitions
- User communications for rollout phases

## Next Steps

1. **Immediate Actions:**
   - Begin Phase 1 backend infrastructure setup
   - Coordinate with security team for compliance requirements
   - Set up monitoring and alerting infrastructure

2. **Week 1-2:**
   - Complete backend AI service infrastructure
   - Begin API endpoint development
   - Prepare frontend migration plan

3. **Week 3-4:**
   - Complete API endpoints and database migrations
   - Begin frontend integration work
   - Conduct security review

4. **Week 5-6:**
   - Complete frontend migration
   - Implement security and compliance measures
   - Begin internal testing

5. **Week 7-8:**
   - Performance optimization
   - Beta testing with selected users
   - Prepare for gradual rollout

## Documentation References

- [DA-3 Chat Tab Implementation](../mandible/documentation/DA3_CHAT_TAB_IMPLEMENTATION.md)
- [AI Integration Documentation](../mandible/documentation/AI_INTEGRATION.md)
- [Backend Structure Document](../backend/documentation/backend_structure_document.md)
- [Cross-Repository Coordination Guide](./CROSS_REPO_COORDINATION.md)

---

**Document Owner:** Project Nexus Coordination Team
**Last Updated:** 2025-06-11
**Next Review:** Weekly during implementation
