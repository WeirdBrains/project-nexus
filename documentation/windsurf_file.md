# .windsurfrfrules

## Project Overview
- **Type:** AI-powered project management and cross-repository coordination system
- **Description:** Centralize task management across multiple repositories while enabling seamless AI agent coordination and automation.
- **Primary Goal:** Centralize task management across multiple repositories while enabling seamless AI agent coordination and automation.

## Project Structure
### Framework-Specific Routing
- **Directory Rules:**
  - Flutter 3.10: lib/[feature]/[screen].dart (feature-first UI organization)
  - Dart Frog 2.2: routes/[route]/index.dart for HTTP endpoints
  - Node.js 18/Express: src/routes/[route].js for orchestrator webhooks
- Example 1: "Flutter 3.10" → `lib/screens/task_list_screen.dart`, `lib/models/task.dart`
- Example 2: "Dart Frog 2.2" → `routes/tasks/index.dart` (GET/POST), `routes/tasks/[id].dart` (handlers)
- Example 3: "React Router 6" → `src/routes/AgentFlow.js` with `createBrowserRouter` (optional central dashboard)

### Core Directories
- **Versioned Structure:**
  - docs/: Centralized cross-repo documentation (auto-synced nightly via scripts)
  - scripts/: Orchestration scripts (`sync_docs.js`, `slack_notify.js`)
  - infrastructure/: DigitalOcean / Terraform configuration
  - service-orchestrator/ (Node.js 18):
    - src/services: GitHub, Slack, AI integrations
    - src/handlers: webhook and event handlers

### Key Files
- **Stack-Versioned Patterns:**
  - tasks.json: JSON-based task database at project root
  - .github/workflows/cross_repo.yml: Cross-repo coordination workflows
  - scripts/sync_docs.js: Auto-synchronization of docs using CodeGuide.dev
  - scripts/slack_notify.js: Slack notification implementation for task and deploy events
  - infrastructure/do-secrets.tf: DigitalOcean secrets management via Terraform

## Tech Stack Rules
- **node@18:** ESM only (`"type":"module"` in package.json), no CommonJS `require`
- **flutter@3.10:** All UI in lib/, assets declared in pubspec.yaml, no logic in assets/
- **dart_frog@2.2:** All route handlers under routes/, no global mutable state
- **factory.ai@latest:** Use Factory.ai SDK for task assignment, follow factory.ai coding conventions
- **augment@latest:** Integrate Augment code-review hooks via GitHub Actions
- **codeguide@1.0:** Documentation generation conforming to CodeGuide.dev schema

## PRD Compliance
- "JSON-based task database (`tasks.json`) with unique IDs, complexity scores (1-10), dependencies, and status tracking.": Enforce `tasks.json` schema validation in `service-orchestrator/src/utils/validateTasks.js`.
- "Automatic task status updates from GitHub PR merges.": GitHub Action in `.github/workflows/cross_repo.yml` must trigger on `pull_request.closed` and update both `tasks.json` and relevant GitHub Issues.

## App Flow Integration
- **Stack-Aligned Flow:**
  - Factory.ai Agent Assignment → `.github/workflows/factory_assignment.yml` clones Project Nexus, reads `tasks.json`, invokes `service-orchestrator/src/services/factoryAssign.js`.
  - Augment Agent Integration → `.github/workflows/augment_review.yml` runs on PR creation, calls Augment API for automated code review.
  - Slack Notifications → `scripts/slack_notify.js` invoked via GitHub Actions; messages posted to `#dev-updates`, `#ai-coordination`, `#alerts`.

---

### Input Context (Priority Order):  
1. techStackDoc (Flutter 3.10, Dart Frog 2.2, node@18)  
2. prd (task DB, AI workflows, cross-repo coordination)  
3. appFlow (Factory.ai, Augment, GitHub Actions, Slack scripts)  
4. answers (centralized docs strategy, multi-agent orchestration)  

### Rules:  
- Derive folder/file patterns directly from exact versions (Flutter 3.10, dart_frog 2.2, node 18).  
- If Flutter 3.10: enforce lib/ feature-first screens and models.  
- If Dart Frog 2.2: enforce routes/ folder for HTTP handlers.  
- Do not mix framework routing patterns (no `routes/` in Flutter, no lib/ in Dart Frog).
