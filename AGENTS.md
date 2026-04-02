# AGENTS.md — Just Think

## Project Overview

**Just Think** is an open-source alternative to [one-sec](https://one-sec.app/). It helps users manage and limit which apps they use on their device by adding intentional friction before opening distracting apps. Built with Flutter, using Riverpod for state management and Isar for local persistence.

Currently focusing on **Android** first. Once the Android version is solid, iOS will follow.

## Workspace Layout

```
just_think.workspace/          # Outer workspace folder (opened in VS Code)
  just_think/                  # Main worktree (branch: main)
  temp/                        # Scratch folder for ALL temporary files
  <feature-branch>/            # Git worktrees for parallel branch work
```

- **Temp folder:** Always use `just_think.workspace/temp/` for any temporary or scratch files (PR bodies, test outputs, diffs, etc.). Never use `/tmp` or other system directories.
- **Git worktrees:** Use `git worktree add` to create sibling directories inside `just_think.workspace/` for parallel branch work. Each worktree sits at the same level as `just_think/` and `temp/`. Example: `git worktree add ../feature-xyz feature-xyz`.

## Tech Stack

- **Framework:** Flutter (Dart SDK ^3.5.3)
- **State Management:** flutter_riverpod ^2.6.1
- **Local DB:** Isar ^3.1.0+1 (via community fork for flutter libs)
- **Persistence:** shared_preferences ^2.3.4
- **Fonts:** google_fonts ^6.2.1
- **Platform APIs:** installed_apps ^1.5.2, current_app (custom fork)
- **Background Service:** flutter_background_service ^5.1.0
- **Routing:** go_router ^14.6.3
- **Animations:** flutter_animate ^4.5.2, mesh_gradient ^1.3.8
- **Notifications:** flutter_local_notifications ^18.0.1
- **File paths:** path_provider ^2.1.5

## Project Structure

```
lib/
  main.dart                          # App entry point, ProviderScope, service event listener
  src/
    controllers/                     # Riverpod controllers (business logic)
      blocked_app_controller.dart    # Currently blocked app state
      installed_apps_controller.dart # Device installed apps
      selected_apps_controller.dart  # User-selected apps to monitor
      theme_controller.dart          # Theme color/mode
    core/                            # Theme, extensions, shared utilities
      app_theme.dart
      background_service.dart        # Background service init + foreground monitoring isolate
      extensions.dart
      router.dart                    # GoRouter with redirect-based overlay navigation
    models/                          # Data models (Isar collections, state)
      app_info_wrapper.dart          # Isar collection for tracked apps
      app_info_wrapper.g.dart
      blocked_app.dart               # Typed model for currently blocked app
      theme_state.dart
    views/
      screens/                       # Full-screen pages
        home_screen.dart             # Main app list + settings
        overlay_screen.dart          # "Are you sure?" intervention screen
      widgets/                       # Reusable UI components
        all_apps_widget.dart
        selected_apps_widget.dart
        theme_color_switch.dart
        theme_mode_switch.dart
```

## Architecture

- **MVC-ish with Riverpod:** Controllers live in `controllers/`, models in `models/`, views in `views/`.
- Controllers are Riverpod providers/notifiers — do not use `setState` for business logic.
- Isar handles local data persistence; generated files (`*.g.dart`) exist alongside models.
- **Background service** runs in a separate isolate, monitors foreground app via `current_app` plugin, and communicates with main isolate via `FlutterBackgroundService` events.
- **GoRouter** handles navigation with `refreshListenable` pattern — router is created once, redirect is re-evaluated when `blockedAppController` changes.
- **Overlay flow:** Background detects blocked app → brings Just Think to foreground → sets `blockedAppController` → GoRouter redirects to overlay screen.

## Conventions

- Use Riverpod (`ConsumerWidget` / `ConsumerStatefulWidget`) for any widget that reads state.
- Keep UI code in `views/`, logic in `controllers/`, data classes in `models/`.
- Theme is dynamic — colors and mode are controlled via `theme_controller.dart`.
- Target platforms: Android primarily, with iOS/macOS/web/desktop scaffolding present.
- **Temp files:** Always use `just_think.workspace/temp/` for scratch/temporary files (PR bodies, test outputs, etc.). Never use `/tmp` or other system dirs.
- **Git worktrees:** For parallel branch work, create worktrees as siblings inside `just_think.workspace/` using `git worktree add ../branch-name branch-name`.

## Build & Run

```bash
flutter pub get
flutter run
```

For code generation (Isar models):

```bash
dart run build_runner build
```

## Git Workflow

- Default branch: `main`
- Use git worktrees under `just_think.workspace/` for parallel branch work. Create them at sibling level: `git worktree add ../branch-name branch-name`.
- List active worktrees: `git worktree list`.
- Remove finished worktrees: `git worktree remove ../branch-name`.
