# Backend Structure Document

This document outlines the backend setup for Project Nexus. It explains how the system is built, how data is managed, the APIs, hosting, security, and more. Anyone reading this will understand how the backend works without needing deep technical knowledge.

## 1. Backend Architecture

### Overall Design

- **Microservice-style with a single core service**: We use Dart Frog (a lightweight web framework in Dart) to serve all APIs and background tasks. This service handles task management, AI agent coordination, documentation sync, and integrations.
- **Event-driven updates**: GitHub webhooks trigger events that update task status, start AI workflows, and send Slack notifications.
- **Modular code structure**: Each feature (tasks, agents, docs, notifications) lives in its own folder. That keeps code organized and easy to maintain.

### Scalability, Maintainability, Performance

- **Horizontal scaling**: We can run multiple instances of the Dart Frog service behind a load balancer to handle more requests.
- **Stateless services**: The core service doesn’t store session data locally. All state lives in the database or external caches, making it simple to spin up or replace instances.
- **Background workers**: Long-running tasks (like AI agent orchestration or doc generation) run in separate worker processes. This keeps the API responsive.
- **Auto-recovery**: If a worker or service instance fails, our orchestration (DigitalOcean App Platform or Kubernetes) restarts it automatically.

## 2. Database Management

### Database Technologies

- **SQL Database**: PostgreSQL (managed by DigitalOcean)
- **Why PostgreSQL?**
  - Strong support for relational data (tasks, dependencies, users)
  - JSONB columns allow flexible fields (e.g., raw task data)
  - Built-in replication and backups for reliability

### Data Structure and Access

- **Relational tables** for core entities:
  - Tasks, Repositories, Users, AgentAssignments, Events/Logs
- **JSONB columns** where flexibility helps:
  - Raw task definitions (from `tasks.json`)
  - Webhook payloads for auditing
- **Indexes** on key columns (task ID, status, repository ID) for fast queries
- **Connection pooling** ensures the app reuses database connections rather than opening a new one each time

## 3. Database Schema

Below is a human-readable overview, followed by SQL statements for PostgreSQL.

### Human-Readable Schema

- **Tasks**: stores every project task along with scores, status, dependencies, and assignment info.
- **Repositories**: lists all target repositories, their names, and URLs.
- **Users**: information about human team members (via GitHub OAuth).
- **AgentAssignments**: logs which AI agent is working on which task and when.
- **Events**: audit table for GitHub and Slack webhook events.

### SQL Schema (PostgreSQL)

```sql
-- Tasks table
drop table if exists tasks;
create table tasks (
  id                serial primary key,
  title             text not null,
  description       text,
  complexity_auto   integer,
  complexity_manual integer,
  status            text not null,
  dependencies      integer[] default array[]::integer[],
  repository_id     integer references repositories(id),
  raw_data          jsonb,
  created_at        timestamptz default now(),
  updated_at        timestamptz default now()
);

-- Repositories table
drop table if exists repositories;
create table repositories (
  id        serial primary key,
  name      text not null,
  url       text not null,
  created_at timestamptz default now()
);

-- Users table
drop table if exists users;
create table users (
  id           serial primary key,
  github_id    text not null unique,
  username     text not null,
  role         text not null,
  created_at   timestamptz default now()
);

-- AgentAssignments table
drop table if exists agent_assignments;
create table agent_assignments (
  id         serial primary key,
  task_id    integer references tasks(id),
  agent_name text not null,
  assigned_at timestamptz default now(),
  status     text not null
);

-- Events table
drop table if exists events;
create table events (
  id         serial primary key,
  type       text not null,
  payload    jsonb,
  created_at timestamptz default now()
);
```

## 4. API Design and Endpoints

### RESTful Approach

We expose a set of RESTful APIs under `/api/v1/`.

### Key Endpoints

- **Tasks**
  - `GET /api/v1/tasks` — List all tasks, with filter options (status, repository)
  - `GET /api/v1/tasks/{id}` — Get details for a single task
  - `POST /api/v1/tasks` — Create a new task (used for manual overrides)
  - `PATCH /api/v1/tasks/{id}/status` — Update task status (triggered by GitHub or manual)

- **Repositories**
  - `GET /api/v1/repositories` — List configured repos
  - `POST /api/v1/repositories` — Add a new repo to the system

- **Users**
  - `GET /api/v1/users` — List users and roles
  - `POST /api/v1/users` — Invite or add a new user via GitHub OAuth

- **Agents**
  - `GET /api/v1/agents` — Current AI agent assignments and statuses
  - `POST /api/v1/agents/assign` — Manually trigger AI agent assignment

- **Webhooks**
  - `POST /api/v1/webhooks/github` — Receives GitHub events (PR merge, commit)
  - `POST /api/v1/webhooks/slack` — Receives Slack commands or interactive messages

### Frontend & CLI Communication

- The Flutter UI and CLI tool both call these endpoints over HTTPS.
- Slack commands hit our Slack webhook, which in turn calls internal APIs.

## 5. Hosting Solutions

- **Cloud Provider**: DigitalOcean
- **Services Used**:
  - Managed Kubernetes (or App Platform) for running Dart Frog services and workers
  - Managed PostgreSQL for the database
  - Load Balancers for distributing traffic
  - Secrets Management to store environment variables and API keys

### Benefits

- **Reliability**: Managed services with automatic failover and backups
- **Scalability**: Easy to add more application instances or database replicas
- **Cost-Effectiveness**: Pay-as-you-grow pricing and predictable monthly billing

## 6. Infrastructure Components

- **Load Balancer**: Routes incoming HTTP/HTTPS traffic to multiple service instances
- **Caching Layer**: (Optional) Redis to cache frequent queries like task lists
- **Content Delivery Network (CDN)**: Cloudflare or DigitalOcean’s CDN for serving static assets (API documentation, docs)
- **Message Queue**: RabbitMQ or Redis Streams to queue background jobs (AI workflows, doc sync)
- **Worker Processes**: Separate pods or instances that handle long-running tasks (AI agent orchestration, documentation generation)

All these pieces talk to each other over secured internal networks.

## 7. Security Measures

- **Authentication**:
  - GitHub OAuth for human users
  - API keys (with scoped permissions) for AI agents
- **Authorization**:
  - Role-based access (Admin, Developer, Viewer)
  - Endpoint guards to ensure only the right roles can call certain APIs
- **Data Encryption**:
  - TLS (HTTPS) for all in-transit data
  - Encryption at rest for PostgreSQL (managed by DigitalOcean)
- **Secrets Management**:
  - All sensitive environment variables and API tokens stored in DigitalOcean Secrets
- **Audit Logging**:
  - All webhook events and agent assignments recorded in the `events` table
  - Slack alerts on repeated failures or unauthorized access attempts

## 8. Monitoring and Maintenance

- **Monitoring Tools**:
  - DigitalOcean Monitoring for CPU, memory, and disk usage
  - Application logs shipped to a central log service (e.g., LogDNA or Papertrail)
  - Uptime checks and alerting via Slack
- **Error Tracking**:
  - Integrate Sentry (or similar) for capturing exceptions in real time
- **Backups & Updates**:
  - Automated daily backups of the PostgreSQL database
  - Rolling updates for application instances to avoid downtime
  - Regular dependency updates and vulnerability scans

## 9. Conclusion and Overall Backend Summary

Project Nexus’s backend is a modular, event-driven system built on Dart Frog and PostgreSQL, hosted on DigitalOcean. It supports automated task updates, AI agent orchestration, and seamless integrations with GitHub and Slack. Our architecture emphasizes scalability (via stateless services and managed Kubernetes), maintainability (clear code boundaries and separate worker processes), and security (OAuth, role-based access, encryption). With robust monitoring and automated backups in place, the backend aligns perfectly with Project Nexus’s goal of centralizing task management and coordinating AI agents across multiple repositories.