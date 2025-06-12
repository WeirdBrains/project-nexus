# Production Deployment Guide

## Manual Production Deployment Process

### Prerequisites
- Access to `mandible-dev` and `mandible-prod` database connections
- GitHub access to WeirdBrains repositories
- DigitalOcean deployment configured

### Step-by-Step Production Deployment

#### 1. Pre-Deployment Safety Checks

```bash
# Check database health
# Use Augment database tools to verify:
# - mandible-dev health status
# - mandible-prod health status
# - Schema alignment between dev and prod
```

**Database Health Verification:**
- Run health checks on both databases
- Compare schemas between dev and prod
- Identify any missing tables, indexes, or constraints

#### 2. Database Schema Alignment

**Manual Schema Updates (if needed):**
```sql
-- Example: Create missing tables in production
CREATE TABLE IF NOT EXISTS public.notifications (
    id varchar(255) NOT NULL,
    sender_id varchar(255) NOT NULL,
    receiver_id varchar(255) NOT NULL,
    type varchar(50) NOT NULL,
    reference_id varchar(255),
    sec_reference_id varchar(255),
    is_read bool DEFAULT false NOT NULL,
    created_at timestamp DEFAULT now() NOT NULL,
    updated_at timestamp DEFAULT now() NOT NULL,
    CONSTRAINT notifications_pkey PRIMARY KEY (id)
);

-- Create missing indexes
CREATE INDEX IF NOT EXISTS idx_notifications_receiver_id 
ON public.notifications USING btree (receiver_id);
```

**⚠️ CRITICAL:** Always apply database changes to production BEFORE deploying code.

#### 3. Backend Deployment

**Repository:** `WeirdBrains/backend`

```bash
# 1. Ensure you're on feature branch with changes
git checkout feature/your-feature-name

# 2. Run backend tests
./test.sh unit

# 3. Verify dependencies
dart pub get

# 4. Create production PR
# Use GitHub API or web interface to create PR:
# - Source: feature/your-feature-name
# - Target: production
# - Include: Database schema changes, API updates

# 5. Merge to production
# This triggers automatic DigitalOcean deployment
```

#### 4. Frontend Deployment (Mandible)

**Repository:** `WeirdBrains/mandible`

```bash
# 1. Update production endpoints
# Edit lib/api/endpoints.dart:
static const String baseUrl = 'https://api.mandible.io';
static const String ssoUrl = 'https://sso.weirdbrains.com';

# 2. Update production SSO credentials
# Edit lib/api/sso.dart:
const String clientId = '34cc606e-fbae-4bf8-840b-2f8b06f214ac';
const String clientSecret = 'f0ef52e6-f75d-4f52-b8d8-d4cab7099324';

# 3. Build production web assets
flutter build web --release --target lib/main_prod.dart

# 4. Commit all changes including build files
git add lib/api/endpoints.dart lib/api/sso.dart build/web/
git commit -m "Deploy to production: Update endpoints and build web assets"

# 5. Create and merge production PR
# - Source: feature/your-feature-name  
# - Target: production
# - Include: Endpoint updates, SSO credentials, web build files
```

#### 5. Post-Deployment Verification

```bash
# 1. Monitor DigitalOcean deployment status
# Check deployment logs and health

# 2. Verify database connections
# Ensure production services connect to mandible-prod

# 3. Test critical functionality
# - API endpoints responding
# - Frontend loading correctly
# - SSO authentication working
# - Database operations successful

# 4. Monitor for errors
# Check logs for any deployment issues
```

### Common Issues and Solutions

#### Issue: Frontend changes not visible
**Solution:** Ensure `build/web/` files are committed to git

#### Issue: API endpoints not working  
**Solution:** Verify endpoints point to production URLs, not localhost

#### Issue: SSO authentication failing
**Solution:** Confirm production client ID/secret are used

#### Issue: Database errors
**Solution:** Verify schema alignment between dev and prod

### Security Notes

- ⚠️ **Never commit actual credentials in commit messages**
- ✅ **Credentials in code files are acceptable for client-side apps**
- ✅ **Always use production credentials for production deployments**
- ✅ **Verify database backups before schema changes**

---

## Future Automation Roadmap

### Phase 1: GitHub Actions CI/CD (Priority: High)

**Goal:** Automate testing and deployment pipeline

**Implementation:**
```yaml
# .github/workflows/backend-production.yml
name: Backend Production Deployment
on:
  push:
    branches: [production]
    paths: ['backend/**']

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Dart
        uses: dart-lang/setup-dart@v1
      - name: Run Tests
        run: |
          cd backend
          dart pub get
          dart test
      
  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to DigitalOcean
        # Configure DigitalOcean deployment
```

**Benefits:**
- Automated testing before deployment
- Consistent deployment process
- Reduced human error
- Deployment history and rollback capability

### Phase 2: Database Migration Automation (Priority: High)

**Goal:** Automate database schema updates

**Implementation:**
```dart
// backend/lib/migrations/migration_runner.dart
class MigrationRunner {
  static Future<void> runMigrations() async {
    // Check current schema version
    // Apply pending migrations
    // Verify migration success
  }
}
```

**Features:**
- Automatic schema version tracking
- Safe migration rollback
- Pre-deployment schema validation
- Migration testing against dev database

### Phase 3: Environment Configuration Management (Priority: Medium)

**Goal:** Centralized environment configuration

**Implementation:**
```yaml
# config/environments/production.yml
api:
  baseUrl: "https://api.mandible.io"
  ssoUrl: "https://sso.weirdbrains.com"
  
database:
  host: "mandible-prod-host"
  name: "mandible_prod"
  
sso:
  clientId: "${SSO_PROD_CLIENT_ID}"
  clientSecret: "${SSO_PROD_CLIENT_SECRET}"
```

**Benefits:**
- Single source of truth for configuration
- Environment-specific settings
- Secure credential management
- Easy configuration updates

### Phase 4: Automated Testing Suite (Priority: Medium)

**Goal:** Comprehensive automated testing

**Components:**
- Unit tests for all repositories
- Integration tests against dev database
- End-to-end testing for critical user flows
- Performance testing for API endpoints

### Phase 5: Monitoring and Alerting (Priority: Medium)

**Goal:** Proactive issue detection

**Features:**
- Real-time deployment monitoring
- Database performance alerts
- API endpoint health checks
- User experience monitoring

### Phase 6: Blue-Green Deployment (Priority: Low)

**Goal:** Zero-downtime deployments

**Implementation:**
- Parallel production environments
- Traffic switching capability
- Automatic rollback on failure
- Database synchronization

---

## Implementation Timeline

### Immediate (Next Sprint)
- [ ] Create GitHub Actions workflows for backend and mandible
- [ ] Implement basic database migration system
- [ ] Set up environment configuration files

### Short Term (1-2 Months)
- [ ] Complete automated testing suite
- [ ] Implement monitoring and alerting
- [ ] Create deployment dashboard

### Long Term (3-6 Months)  
- [ ] Blue-green deployment system
- [ ] Advanced rollback capabilities
- [ ] Cross-service deployment coordination

---

## Getting Started with Automation

1. **Start with GitHub Actions:** Create basic CI/CD workflows
2. **Database Migrations:** Implement migration system for schema changes
3. **Environment Config:** Centralize configuration management
4. **Monitoring:** Add basic health checks and alerts
5. **Iterate:** Gradually add more sophisticated automation

This approach balances immediate needs with long-term automation goals while maintaining system reliability.
