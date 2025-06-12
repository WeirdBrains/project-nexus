# Tech Stack Document for Project Nexus

This document explains, in everyday language, the technology choices behind Project Nexus—our AI-powered, multi-repository project management system. It’s designed to help both technical and non-technical readers understand why each tool was picked and how it fits into the overall solution.

## Frontend Technologies

Our goal on the frontend is to give users a clean, responsive interface that works in a browser, on the command line, and right inside Slack. Here’s how we do that:

- **Flutter (Dart)**
  - Powers the web-based dashboard (mandible repo) with a single codebase that looks and feels modern
  - Provides hot-reload for rapid UI tweaks and a rich set of built-in components for forms, tables, and charts
- **Node.js (JavaScript)**
  - Drives our command-line interface (CLI) commands like `nexus list`, `nexus assign`, and `nexus override`
  - Integrates with the same JSON task files and GitHub Issues behind the scenes, so web, CLI, and chat all stay in sync
- **JSON**
  - Stores task definitions, IDs, complexity scores, dependencies, and status
  - Is easy to read and write by humans and machines alike, making configuration transparent
- **Markdown**
  - Formats all documentation, README files, and auto-generated guides in a universally supported text format
  - Lets AI tools (like CodeGuide.dev) append or regenerate sections without disturbing existing content
- **AI-Enhanced Editors & IDEs**
  - **VS Code**, **Windsurf**, **Cursor**, **Cline**, **Gemini 2.5 Pro**
  - Provide real-time coding suggestions, context-aware completions, and integrated AI assistance to boost developer productivity

These technologies combine to give users a smooth, consistent experience across mouse-driven, keyboard-driven, and chat-driven workflows.

## Backend Technologies

On the backend, we need reliable APIs, simple yet powerful data storage for tasks, and pure-play services for each target repository:

- **Dart Frog (Dart)**
  - Serves the REST APIs in the `backend` repository, connecting to a **PostgreSQL** database
  - Known for fast startup, lightweight runtime, and seamless Dart language alignment with Flutter
- **Node.js (JavaScript/TypeScript)**
  - Hosts our automation scripts, orchestrates AI agent calls, and interacts with GitHub & Slack APIs
- **PostgreSQL**
  - Stores structured data for the core backend services, especially where complex queries or joins are needed
- **Flat-File JSON + GitHub Issues**
  - JSON files (`tasks/tasks.json`) remain the source of truth for task definitions
  - We complement them with GitHub Issues and Projects for richer collaboration, comments, and built-in tracking
- **MCP Tools**
  - Implements the Model Context Protocol for sharing context and metadata with AI agents
  - Helps keep task data consistent across multiple agents and repositories
- **APIs & Libraries**
  - **GitHub REST API** for cloning repos, creating issues, monitoring pull requests, and syncing statuses
  - **Slack API** for sending notifications, responding to slash commands, and reporting errors
  - **Factory.ai & Augment** SDKs for multi-agent task orchestration and code review
  - **Context7** for fetching external library docs and code examples on demand

Together, these backend pieces make it easy to coordinate work across four repositories (mandible, backend, sso_backend, accounts) while keeping data accurate and up to date.

## Infrastructure and Deployment

We host and deploy everything in a way that’s automated, scalable, and easy to maintain:

- **DigitalOcean**
  - Runs our droplets (virtual machines) for production, staging, and development environments
  - Provides a built-in secrets manager for environment variables (hostnames, database URIs, API keys)
  - Offers monitoring for CPU, memory, uptime, and spend
- **GitHub**
  - Manages source code across all repositories with pull requests and protected branches (`main` and `development`)
  - Triggers **GitHub Actions** workflows to build, test, and deploy code to DigitalOcean on merges to `production`
- **CI/CD Pipeline**
  - Automatically lint, test, and build before any merge
  - Deploys containers or droplets, runs database migrations, and performs health-check validations
  - Rolls back or alerts on failure

This setup ensures reproducible deployments, clear auditing (everything is a Git commit), and real-time visibility into system health.

## Third-Party Integrations

Project Nexus leverages several external services to extend functionality without reinventing the wheel:

- **Factory.ai**
  - Orchestrates multi-agent workflows, assigns tasks to specialized AI agents, and tracks progress
- **Augment**
  - Acts as a remote AI pair programmer and code reviewer, improving code quality and accelerating development
- **CodeGuide.dev**
  - Generates and maintains Markdown documentation based on code changes and AI analysis
- **Slack**
  - Channels: `#dev-updates`, `#ai-coordination`, `#alerts`
  - Formats messages like:
    - `[GitHub] Task #XX completed in [Repo] by [Agent/Developer]`
    - `[Slack] Deployment successful for [Repo] on [Date]`
- **GitHub Webhooks**
  - Fire on PR merges, issue creations, and comment events to keep the JSON store and GitHub Issues in sync
- **Context7**
  - Provides library reference docs and code snippets to both developers and AI agents
- **Monitoring Tools**
  - Use DigitalOcean’s built-in metrics or plug into Grafana/Datadog for advanced dashboards and alerting

These integrations make it easy to automate status updates, code reviews, documentation, and real-time communication.

## Security and Performance Considerations

We’ve built Project Nexus with security and speed in mind:

- **Authentication & Access Control**
  - **GitHub OAuth** for human users—leverages GitHub’s existing security and permission model
  - **API Keys** scoped per AI agent and service—kept in DigitalOcean’s secrets manager
  - Role-based permissions: Admins, Developers, Viewers, and AI agents with just-enough access
- **Secrets Management**
  - No hard-coded credentials—everything comes from environment variables in a secure vault
  - Access logs and audit trails for every config change and API key usage
- **Data Protection**
  - HTTPS/TLS everywhere (GitHub, Slack, DigitalOcean)
  - Database credentials rotated regularly and limited by network rules
- **Performance Optimizations**
  - Incremental data updates triggered only by real events (PR merge, commit)
  - Parallel agent workflows for independent tasks to reduce turnaround time
  - Caching of API calls where safe (e.g., Context7 docs, code samples)
- **Monitoring & Alerts**
  - CPU ≥ 80% and Memory ≥ 75% trigger automatic alerts in Slack
  - Transient failures get two automatic retries, then escalate to a human on‐call
  - Uptime target of 99.9% with monthly spend alerts for cost control

These measures protect our data, control who can do what, and keep the system snappy and reliable.

## Conclusion and Overall Tech Stack Summary

Project Nexus brings together a carefully chosen set of technologies to meet our goals:

- A **web UI**, **CLI**, and **Slack interface** built on **Flutter**, **Node.js**, **JSON**, and **Markdown**
- A **backend** powered by **Dart Frog**, **Node.js**, **PostgreSQL**, and the **GitHub API**
- **AI-driven** coordination using **Factory.ai**, **Augment**, and **MCP Tools**
- **AI-generated documentation** with **CodeGuide.dev** and nightly link-checking scripts
- **Reliable hosting and CI/CD** on **DigitalOcean** with **GitHub Actions**
- **Secure access** via **GitHub OAuth**, scoped **API keys**, and a secrets manager
- **Real-time notifications** and **monitoring** via **Slack**, **webhooks**, and built-in DigitalOcean metrics

This unified stack puts AI agents and humans in the same workflow, automates routine tasks, and centralizes management across multiple repositories—making Project Nexus a standout solution for modern, multi-agent development teams.