# Frontend Guideline Document

This document outlines the frontend architecture, design principles, styling, component organization, state management, routing, performance optimizations, and testing strategies for Project Nexus. It is written in everyday language to ensure clarity for all team members.

## 1. Frontend Architecture

### 1.1 Overview
- We use **Flutter** to build a single codebase that targets web and mobile. This ensures consistency in look and feel and speeds up development.
- The app is organized as a feature-based, modular structure: each major area (Tasks, Reports, Settings) lives in its own folder with its pages, widgets, and tests.
- We leverage Flutter’s **MaterialApp** as the root, with custom theming layered on top.

### 1.2 Scalability, Maintainability & Performance
- **Modular features**: Adding a new screen or feature only requires creating a new folder and wiring it into routing—minimal impact on existing code.
- **Reusability**: Common widgets (buttons, cards, form fields) live in a shared `components/` directory, preventing duplication.
- **Lazy loading**: Large feature modules are loaded on demand to reduce initial bundle size (via Flutter’s deferred imports).
- **Clear separation**: UI code, business logic, and data models are kept in different files, making it easy to understand and update.

## 2. Design Principles

### 2.1 Usability
- Keep interfaces simple and focused: one primary task per screen.
- Use clear labels, consistent button placements, and intuitive icons.

### 2.2 Accessibility
- All tappable elements are at least 48×48 px.
- Provide meaningful semantic labels for screen readers.
- Ensure color contrast meets WCAG AA standards.

### 2.3 Responsiveness
- Layouts adapt smoothly from mobile (320 px) to desktop (1440 px).
- Use `LayoutBuilder` and `MediaQuery` to adjust padding, columns, and font sizes.
- Hide or collapse non-essential panels on smaller screens.

## 3. Styling and Theming

### 3.1 Styling Approach
- We follow Flutter’s **Material Design** but in a modern, flat style with occasional glassmorphism effects on dialogs and cards (subtle blur and translucency).
- All styles live in a centralized `theme/` folder, using `ThemeData` to define colors, typography, and shapes.

### 3.2 Theming
- **Light and dark themes** are supported out of the box. Users can toggle in Settings.
- Theme overrides (e.g., error color, accent) are set in `AppTheme.light()` and `AppTheme.dark()` constructors.

### 3.3 Color Palette
- Primary: `#1E88E5` (blue)
- Secondary: `#546E7A` (blue-grey)
- Background (light): `#F5F5F5` / (dark): `#121212`
- Surface: `#FFFFFF` / `#1E1E1E`
- Error: `#E53935`
- Accent: `#FFB300` (amber)
- Text (light on dark): `#FFFFFF`; Text (dark on light): `#000000`

### 3.4 Typography
- Main font: **Roboto**, regular, medium, and bold weights.
- Headlines: 24–32 sp; Body: 14–16 sp; Captions: 12 sp.

## 4. Component Structure

### 4.1 Directory Layout
```
lib/
├── components/        # Shared widgets (buttons, cards, dialogs)
├── features/          # Feature modules (tasks/, reports/, settings/)
│   └── tasks/
│       ├── data/      # Models and data providers
│       ├── logic/     # State notifiers or blocs
│       └── ui/        # Screens and widgets
├── theme/             # ThemeData definitions
└── main.dart          # App entry point
```

### 4.2 Reusability
- Common components have a clear API: inputs via constructor parameters, outputs via callbacks.
- Visual variants (e.g., primary vs. secondary buttons) are styled via theme tokens.

## 5. State Management

### 5.1 Approach
- We use **Riverpod** for global and scoped state management:
  - **Providers** for read-only values (e.g., current user).
  - **StateNotifierProviders** for mutable state (e.g., task list, filter settings).

### 5.2 Data Flow
- UI widgets read state via `ref.watch(...)` and trigger changes via `ref.read(...).update(...)`.
- Side effects (API calls, JSON file updates) live in separate service classes and are invoked by controllers or notifiers.
- State changes automatically notify listening widgets, ensuring UI stays in sync.

## 6. Routing and Navigation

### 6.1 Routing Library
- We use **go_router**, which sits on top of Navigator 2.0 for declarative, URL-based routing.

### 6.2 Route Structure
```dart
final _router = GoRouter(
  initialLocation: '/tasks',
  routes: [
    GoRoute(
      path: '/tasks',
      builder: (ctx, state) => TaskListScreen(),
      routes: [
        GoRoute(
          path: 'detail/:id',
          builder: (ctx, state) => TaskDetailScreen(id: state.params['id']!),
        ),
      ],
    ),
    GoRoute(path: '/settings', builder: (_, __) => SettingsScreen()),
  ],
);
```
- Nested routes allow shared layouts (e.g., a side rail) and deep linking.

## 7. Performance Optimization

### 7.1 Lazy Loading & Code Splitting
- Feature modules (e.g., reports) are imported with `deferred as` to load them only when needed.

### 7.2 Widget Optimizations
- Use `const` constructors wherever possible to reduce rebuilds.
- Avoid large build methods; split complex layouts into smaller widgets.

### 7.3 Asset Optimization
- Compress images and SVGs.
- Cache network images with `cached_network_image`.

## 8. Testing and Quality Assurance

### 8.1 Unit Tests
- Test pure Dart classes: data models, utility functions, state notifiers.
- Use `flutter_test` and `mocktail` for mocking dependencies.

### 8.2 Widget Tests
- Verify individual widgets render correctly under various states.
- Use `pumpWidget()` with Riverpod `ProviderScope` overrides.

### 8.3 Integration Tests
- Use `integration_test` package to run end-to-end scenarios (task creation, status updates).
- Automate tests in CI pipelines for each pull request.

### 8.4 Code Coverage & Linting
- Aim for 80%+ coverage on core features.
- Use `analysis_options.yaml` with Flutter recommended lint rules.
- Enforce formatting via `flutter format` and pre-commit hooks.

## 9. Conclusion and Overall Frontend Summary

Project Nexus’s frontend uses a **Flutter + Riverpod + go_router** stack, built around Material Design in a modern, flat style with optional glassmorphism accents. Its modular, feature-first folder structure and clear separation of UI, logic, and data make it easy to scale and maintain. By following these guidelines—focusing on usability, accessibility, performance, and a robust testing strategy—we ensure the app remains fast, reliable, and delightful for all users.