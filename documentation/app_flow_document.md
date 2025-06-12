# App Flow Document for Project Nexus

## Onboarding and Sign-In/Sign-Up

When a new user arrives at the Project Nexus landing page, they are presented with a clear prompt to sign in via GitHub OAuth. Clicking the sign-in button redirects the user to GitHub, where they grant permission for Project Nexus to read and write to the specified repositories. Once the user authorizes the application, they are redirected back to Project Nexus and automatically logged in. The system then assigns the user a role—administrator, developer, or viewer—based on predefined permissions stored in the configuration. Administrators gain full access to all settings and user management features, developers can create and modify tasks and pull requests, and viewers can monitor progress without making changes. If a user loses access or needs to switch GitHub accounts, they can log out from the profile menu on the top right and repeat the sign-in process. There is no local password flow, since all user authentication is handled through GitHub OAuth. In parallel, AI agents obtain access by generating secure API keys in the user’s account settings. These keys are scoped to specific repositories and services and are used by Factory.ai and Augment agents to perform automated tasks without exposing credentials.

## Main Dashboard or Home Page

After signing in, the user lands on the main dashboard, which features a top navigation bar, a sidebar, and a main content area. The navigation bar shows the Project Nexus logo on the left and an environment selector on the right, allowing the user to switch between development, staging, and production contexts. The sidebar contains links to key sections: Tasks, Cross-Repository View, AI Agents, Documentation, Notifications, and Settings. In the main content area, the default dashboard view displays a summary of active, pending, and completed tasks, a real-time status widget for recent GitHub events, and a Slack activity feed. From here, the user can click on any section in the sidebar to navigate deeper into the application or use the environment selector to view metrics and configurations for a different environment. Quick-access buttons in the header let the user switch to the CLI interface or view Slack slash-command documentation without leaving the dashboard.

## Detailed Feature Flows and Page Transitions

### Creating and Managing Tasks

When the user clicks the “Tasks” link in the sidebar, they see a paginated list of tasks drawn from the central tasks.json file and synchronized GitHub Issues. Each task entry shows its ID, title, complexity score, and status. The user can click “New Task” in the header to open the task creation form. Here they enter a title, description, repository mapping, and optionally adjust the AI-generated complexity score. They declare dependencies by typing related task IDs into a text field. On submission, the system validates inputs, prevents circular dependencies, and writes the new record to tasks.json. At the same time, a matching GitHub Issue is created via the GitHub API. After saving, the dashboard returns to the task list with the new task highlighted.

### AI Agent Workflow

Within the “AI Agents” section, the user sees available Factory.ai and Augment agents. To onboard a new agent, they click “Add Agent,” select the agent type, and choose a scope of tasks by ID range or repository. The system provisions an API key for the agent and stores it securely. To launch an agent workflow on a specific task, the user navigates back to that task’s detail page and clicks “Assign to AI.” The system instructs the agent to clone the main Project Nexus repo and the target repository based on mapping. As the agent works, incremental commits and pull requests appear under the agent’s name in the task detail view. Once the pull request merges, the task status transitions automatically from “In Progress” to “Completed,” and the main dashboard is updated in real time.

### Cross-Repository Coordination

Clicking “Cross-Repository View” opens an interactive timeline that visualizes tasks across WeirdBrains/mandible, WeirdBrains/backend, WeirdBrains/sso_backend, and WeirdBrains/accounts. Each task appears as a node on the timeline, colored by status. Dependencies are drawn as arrows. When the user hovers over a node, a tooltip shows key details, and clicking the node opens the full task detail page. Independent tasks appear side by side, allowing the user to launch parallel agent workflows from within this view. If conflicting changes arise between branches or repositories, an alert icon appears on the node, and clicking it launches a merge conflict resolution interface that displays diffs side by side and guides the user through conflict resolution.

### Documentation Management

The “Documentation” link leads to a central docs directory view. The user sees a list of documents with live status badges that indicate link health. Clicking a document opens it in a markdown viewer with an auto-synchronized table of contents. Under the hood, a nightly script checks each link, updates file paths, and regenerates sections. When code changes occur in any repository, AI-generated content from CodeGuide.dev is appended to relevant documentation sections. Users can click “Refresh Links” at any time to trigger an on-demand synchronization.

### Real-Time Notifications and Reporting

In the “Notifications” section, the user configures Slack channels and report schedules. They choose which events trigger Slack messages—for example, pull-request merges, AI agent starts, or errors—and select channels like #dev-updates, #ai-coordination, and #alerts. The user can also opt in to daily or weekly summary reports delivered as Slack attachments or emailed PDFs. When events occur, formatted messages such as “Task #12 completed in backend by Augment Agent” appear in the chosen channels instantly.

### Environment Configuration and Deployment

The “Settings” sidebar includes an environment tab where the user selects development, staging, or production. Each environment reads its hostnames, database URIs, and API keys from DigitalOcean’s secrets management service. The user never sees raw credentials; they simply click “Deploy Production” to merge the production branch, trigger the CI/CD pipeline, and deploy updated containers. The system runs database migrations and performs health checks. On success, the dashboard marks the deployment as complete and sends a Slack notification to #dev-updates.

### Administering System Settings

Under “Settings,” the administrator accesses the branding and permissions panel. They can upload logos, set primary color palettes, and choose fonts. They may edit user roles and API key scopes or revoke agent access keys. All changes are versioned via Git commits so there is a complete audit trail. After saving, the user is returned to the dashboard to continue regular tasks.

## Settings and Account Management

Users manage their profile by clicking their avatar in the top navigation bar, which opens a profile page showing GitHub account details and assigned role. Here they can log out or switch accounts through GitHub OAuth. Notification preferences let users toggle email alerts or Slack messages for various event types. Administrators see an additional tab for billing and subscription settings, although initial usage of Project Nexus is free. If billing becomes relevant, the user can enter payment details on that tab and view past invoices. After making any changes, the user clicks “Save” and is returned to the dashboard to resume work.

## Error States and Alternate Paths

If a user attempts to create a task with missing fields or circular dependencies, the form displays an inline error message and highlights the offending inputs. During GitHub OAuth, if the user denies scopes, they are shown a clear message explaining that access cannot proceed without the requested permissions and can retry the sign-in. When an AI agent or integration step fails, the system automatically retries the operation twice. If it still fails, a red error banner appears in the dashboard and a Slack alert is sent to #alerts. The user can click the banner to view detailed logs and either manually intervene or escalate to the on-call developer. Network outages trigger a familiar offline banner, and once connectivity is restored, the dashboard synchronizes in the background to catch up on missed events.

## Conclusion and Overall App Journey

From the moment a new user visits the landing page and signs in with GitHub OAuth, through the creation and management of tasks, to the assignment of AI agents and real-time cross-repository coordination, Project Nexus guides the user with clear pages and seamless transitions. Users switch effortlessly between the web UI, CLI commands, and Slack integrations to fit their workflow. Administrators configure branding, roles, and environments in one place, while all critical events generate instant notifications and reports. Error states are handled gracefully, with automatic retries and clear escalation paths. By bringing together AI-powered automation, centralized task management, and integrated team communication, Project Nexus delivers a coherent experience from sign-up to everyday usage and helps teams drive multi-repository projects to completion.