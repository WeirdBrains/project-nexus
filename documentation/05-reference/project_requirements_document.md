# Project Requirements Document for Project Nexus

## 1. Project Overview

Project Nexus is an AI-powered project management system designed to coordinate tasks across multiple code repositories. It centralizes task definitions, tracks dependencies and complexity scores, and automates status updates by integrating with GitHub, Slack, and DigitalOcean. AI agents from Factory.ai and Augment work alongside human developers to assign, implement, and review tasks, making multi-repo workflows seamless.

We’re building Project Nexus to solve the pain of juggling separate repositories and manual status tracking in multi-agent development teams. Key objectives are to reduce manual coordination, speed up task resolution, and maintain clear, up-to-date documentation. Success is measured by faster task completion rates, fewer unresolved dependencies, high AI-agent pull-request approval rates, and up-to-date documentation links.

## 2. In-Scope vs. Out-of-Scope

### In-Scope (Version 1.0)

*   Central dashboard (Web UI) for creating, viewing, and editing tasks stored in `tasks.json`.

*   Command-Line Interface (CLI) commands (`nexus list`, `nexus assign`, `nexus override`).

*   Slack slash commands for task queries and status updates.

*   JSON-based task database with unique IDs, complexity scores, dependency tracking, and status fields.

*   GitHub Issue sync layer for enhanced collaboration.

*   AI agent workflows via Factory.ai and Augment: cloning repos, subtask commits, PR creation, and automatic status updates.

*   Cross-repository mapping of tasks to four target repos:

    *   `mandible` (Flutter frontend)
    *   `backend` (Dart Frog + PostgreSQL)
    *   `sso_backend` (SSO services)
    *   `accounts` (user management)

*   GitHub webhooks for pull-request merges and issue events.

*   Slack channels for notifications: `#dev-updates`, `#ai-coordination`, `#alerts`.

*   Environment management (development, staging, production) via environment variables stored in DigitalOcean’s secrets manager.

*   Automatic retries and escalation for failed AI tasks, with Slack alerts and human intervention.

*   Real-time monitoring of CPU, memory, uptime, and spend via DigitalOcean or third-party dashboards.

*   User roles and permissions via GitHub OAuth for humans and scoped API keys for AI agents.

*   Basic branding controls (colors, fonts) in settings panel.

### Out-of-Scope (Future Phases)

*   Native mobile app for the dashboard.
*   Advanced analytics beyond core KPIs (e.g., custom BI dashboards).
*   Integration with non-GitHub version control systems.
*   Deep offline support or local network hosting.
*   Custom plugin system for third-party extensions.
*   Multi-language localization.

## 3. User Flow

When a user or AI agent first accesses Project Nexus, they choose one of three interfaces: the web dashboard, CLI, or Slack commands. A human developer clicks “Sign in with GitHub” and grants OAuth access, after which they see a role-based dashboard showing active, pending, and completed tasks. AI agents use pre-configured API keys to authenticate automatically.

From the dashboard, a user can create a new task by filling in title, description, complexity estimate, and repository mapping. Project Nexus assigns a unique ID, records it in `tasks.json`, and opens a matching GitHub Issue. Users and AI agents can then trigger Factory.ai or Augment workflows: the system instructs agents to clone the main repo and the target repo, implement changes, open a pull request labeled “Task #XX,” and automatically update the task status on merge. Real-time Slack notifications keep the team informed at each step.

## 4. Core Features

*   **Task Management System**\
    • JSON-based storage (`tasks.json`) with unique IDs, descriptions, AI-generated complexity (1–10), dependencies, and status.\
    • Circular dependency detection and prevention.\
    • Manual override of complexity scores and dependencies via UI or CLI.
*   **Multi-Interface Access**\
    • Web UI: full dashboard for task creation, editing, and cross-repo views.\
    • CLI: quick commands (`nexus list`, `nexus assign`, `nexus override`).\
    • Slack Commands: `/nexus tasks`, `/nexus assign`, `/nexus status`.
*   **AI Agent Coordination**\
    • Factory.ai for structured multi-agent orchestration.\
    • Augment for remote code review and development assistance.\
    • MCP Tools for context sharing and database interactions.\
    • Automated agent workflows: clone repo, implement subtasks, open PR, post status.
*   **Cross-Repository Integration**\
    • Mapped tasks to `mandible`, `backend`, `sso_backend`, and `accounts`.\
    • GitHub webhooks on `main` and `development` branches for PR merges and issue events.\
    • Unified cross-repo dependency graph and conflict resolution UI.
*   **Documentation Management**\
    • Hybrid docs: repo-specific files stay local; cross-cutting docs in central `docs/`.\
    • Auto-sync script checks and fixes broken Markdown links nightly.\
    • AI-generated guides from CodeGuide.dev appended on code changes.
*   **Team Coordination & Notifications**\
    • Slack channels: `#dev-updates`, `#ai-coordination`, `#alerts`.\
    • Formatted messages:\
    – “[GitHub] Task #XX completed in [Repo] by [Agent/Developer]”\
    – “[Slack] Deployment successful for [Repo] on [Date]”\
    • Daily/weekly summary reports via Slack or email.
*   **Environment & Deployment**\
    • Environments: development, staging, production.\
    • Secrets via DigitalOcean’s manager for hostnames, DB credentials, API keys.\
    • Automatic container deployments on branch merges with health checks.
*   **Monitoring & Reporting**\
    • Infrastructure metrics: CPU ≥ 80%, memory ≥ 75%, uptime ≥ 99.9%, spend alerts.\
    • AI agent KPIs: utilization rate, PR approval rate, code-quality scores.\
    • Task metrics: completion rate, dependency resolution time.

## 5. Tech Stack & Tools

*   **Core Languages & Frameworks**\
    • JavaScript / Node.js (automation scripts)\
    • Dart / Flutter (frontend in `mandible`)\
    • Dart Frog + PostgreSQL (`backend`)
*   **Configuration & Data**\
    • JSON (task definitions)\
    • Markdown (docs)
*   **Version Control & Hosting**\
    • Git / GitHub (repos, branches, webhooks)\
    • DigitalOcean (cloud hosting, secrets manager, monitoring)
*   **AI & Automation**\
    • Factory.ai (multi-agent orchestration)\
    • Augment (remote coding assistance & review)\
    • MCP Tools (Model Context Protocol for DB/task coordination)\
    • CodeGuide.dev (AI documentation generation)\
    • Gemini 2.5 Pro (thinking model for complex problem solving)
*   **IDE & Plugins**\
    • Windsurf (modern AI-integrated IDE)\
    • Cline (collaborative AI coding partner)\
    • Cursor (real-time AI suggestions)\
    • VS Code + relevant extensions
*   **Communication & Collaboration**\
    • Slack (team chat, slash commands, alerts)\
    • GitHub OAuth + API Keys (auth for humans and agents)

## 6. Non-Functional Requirements

*   **Performance**\
    • Dashboard should load in under 2 seconds.\
    • API responses under 200 ms for task queries.
*   **Security**\
    • OAuth for human users; scoped API keys for AI agents.\
    • Secrets manager for environment variables.\
    • Role-based access control mapped to GitHub permissions.
*   **Reliability & Availability**\
    • 99.9% uptime target.\
    • Automatic retries (×2) on transient failures, then escalation.
*   **Usability**\
    • Intuitive web UI with clear forms and status badges.\
    • Simple CLI syntax and helpful usage messages.\
    • Readable Slack messages with context links.
*   **Compliance**\
    • All data stored in GitHub or DigitalOcean per company policies.\
    • Audit logs for config changes via Git commits.

## 7. Constraints & Assumptions

*   JSON files are the primary task store; GitHub Issues augment collaboration.
*   Factory.ai, Augment, and MCP Tools must be available and accessible by API keys.
*   No existing branding resources—use neutral blues/grays and Roboto/Open Sans fonts.
*   Slack workspace and channels (`#dev-updates`, `#ai-coordination`, `#alerts`) are pre-configured.
*   DigitalOcean provides secrets management and monitoring; third-party dashboards optional.
*   Human users have GitHub accounts; AI agents rely on API keys issued by admins.

## 8. Known Issues & Potential Pitfalls

*   **API Rate Limits**: GitHub or Slack may throttle requests. Mitigation: batch updates, exponential backoff.
*   **Circular Dependencies**: Complex task graphs risk loops. Mitigation: real-time cycle detection and UI warnings.
*   **Merge Conflicts**: Parallel agent PRs can conflict. Mitigation: conflict resolution interface and human override.
*   **Credential Leaks**: Misconfigured secrets could leak keys. Mitigation: strict access controls, automated secrets scans.
*   **Link Rot in Docs**: Repo refactoring can break links. Mitigation: nightly link-check script and auto-sync.
*   **AI Misclassifications**: Incorrect complexity scores or mappings. Mitigation: manual override UI and review workflow.

This PRD provides a clear blueprint for Project Nexus. Each section offers enough detail for technical specifications, design guidelines, and implementation plans to follow unambiguously.
