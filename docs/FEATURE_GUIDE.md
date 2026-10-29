# Feature implementation guide

This repository is a mobile foundation, not a generic framework. Add a feature only when the product needs it, and keep its code close to its UI and state.

## Suggested shape

```text
lib/
  app/                         # app setup, router, global preferences
  core/
    design_system/             # tokens, theme, genuinely reusable UI
    localization/              # shared English/Arabic copy
  features/
    example_feature/
      data/                    # only if a real data source is needed
      domain/                  # only if meaningful domain rules exist
      presentation/
        example_page.dart
        example_controller.dart
```

Do not create every folder automatically. A small feature may need only `presentation/`; add data or domain layers when they solve a real problem.

## Implementation sequence

1. Define the user outcome and the normal, loading, empty, error, and recovery states.
2. Add feature-specific UI under `features/<feature>/presentation/`.
3. Keep state in Riverpod; prefer `Notifier` or `AsyncNotifier` for new stateful workflows. Avoid parallel state-management systems.
4. Use `go_router` for navigation and preserve expected system back behavior.
5. Put shared visual rules in `core/design_system/`. Promote a widget to shared UI only when reuse is real, and keep feature-specific copy outside generic components.
6. Add English and Arabic strings through `AppLocalizations`; verify RTL rather than merely translating labels.
7. Test meaningful state transitions and actions. Prefer behavior tests over tests that only assert implementation details.
8. Run format, analysis, and tests; update docs when setup or behavior changes.

## Boundaries

- Android and iOS only; no web or desktop targets by default.
- No generated source, Freezed, backend, analytics, auth, or network dependency without an explicit requirement.
- Do not hardcode secrets, log sensitive data, or silently swallow recoverable errors.
- Avoid fixed-height text containers, color-only state indicators, and motion that ignores reduced-motion preferences.
- Never report checks as passing unless they were actually run and passed.

## Shared feedback states

Use `AppEmptyState` for a feature with no content and `AppErrorState` for a recoverable failure. Their copy is supplied by the caller so each feature can source localized text from `AppLocalizations`. Error actions should retry or offer a meaningful recovery path, not simply dismiss the message.
