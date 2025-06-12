# Repository Dependencies

## Core Dependencies
- mandible → backend, sso_backend, accounts
- backend → sso_backend, infrastructure
- accounts → sso_backend, sso_widgets
- sso_backend → infrastructure

## Integration Points
- All frontends → backend (API calls)
- All services → sso_backend (authentication)
- All deployments → infrastructure (hosting)
