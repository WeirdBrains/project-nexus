# Local Testing Automation

Automated setup for testing WeirdBrains with Chrome using localhost backends and remote development databases.

## Global Command Installation

### 🔧 Install Global `wbtest` Command
```bash
./scripts/install-wbtest.sh
```

Choose between:
- **Shell Function** (recommended) - Adds to your shell config
- **Global Binary** - Creates system-wide `/usr/local/bin/wbtest`

### 🚀 Global Usage (after installation)
```bash
wbtest           # Start everything
wbtest stop      # Stop everything
wbtest status    # Check what's running
wbtest test      # Test Phase 1
wbtest chrome    # Live development
wb               # Short alias
```

## Local Scripts (without global install)

### 🚀 Start Everything
```bash
./scripts/start-local-testing.sh
```

### 🛑 Stop Everything
```bash
./scripts/stop-local-testing.sh
```

## What It Does

### Architecture
- **Frontend**: `http://localhost:3000` (Chrome)
- **Backend**: `http://localhost:8085` → Remote Dev DB (`mandible-dev-do-user-16355324-0.m.db.ondigitalocean.com`)
- **SSO Backend**: `http://localhost:8080` → Remote Dev DB (`sso-dev-do-user-16355324-0.m.db.ondigitalocean.com`)

### Automated Steps
1. **Configures endpoints** to use localhost backends with dev credentials
2. **Starts backend services** (if not already running)
3. **Builds Flutter web** with optimizations
4. **Starts web server** on port 3000
5. **Opens Chrome** automatically

## Manual Makefile Commands

### Development with Live Reload
```bash
make run-local-chrome
```

### Build Web Only
```bash
make build-local-web
```

### Serve Pre-built Web
```bash
make test-local-web
```

## Testing Phase 1 Implementation

Once running, test the chat error handling:

1. **Navigate to**: `http://localhost:3000/chats/non-existent-chat-id`
2. **Expected**: Should show `ChatNotFoundView` instead of crashing
3. **Test all views**:
   - Messages: `/chats/missing-id`
   - Details: `/chats/missing-id/details`
   - Edit: `/chats/missing-id/edit`

## Configuration Files Modified

The automation temporarily modifies these files:
- `lib/api/endpoints.dart` → localhost URLs
- `lib/api/sso.dart` → dev credentials
- Firebase configs → dev versions

**Important**: Files are automatically reverted to production values by `make gen-prod` before deployment.

## Troubleshooting

### Port Already in Use
```bash
# Check what's using the port
lsof -i :3000
lsof -i :8080  
lsof -i :8085

# Kill specific processes
pkill -f "python3 -m http.server 3000"
pkill -f "dart run bin/server.dart"
```

### Backend Not Starting
1. Check `.envrc` files are loaded: `cd ../backend && direnv allow`
2. Check database connectivity
3. Verify environment variables: `env | grep DB_`

### Frontend Build Issues
```bash
# Clean and rebuild
make clean
flutter pub get
make build-local-web
```

## Benefits

✅ **Real Data**: Uses actual development databases  
✅ **Fast Iteration**: Local backends respond instantly  
✅ **Easy Debugging**: See backend logs in real-time  
✅ **Automated**: One command starts everything  
✅ **Safe**: Automatically reverts config changes
