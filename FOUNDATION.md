# White Space — Flutter Foundation

**Status:** Project baseline  
**Scope:** Reusable foundations for production-quality Flutter applications on Android and iOS only.  
**Authority:** This document is the single source of truth for foundational engineering, product, design, quality, and AI-agent behavior. A project-specific specification may add requirements, but may not silently weaken these rules. Only the project owner may explicitly change a fixed requirement.

## 1. How to interpret this document

- **MUST / MUST NOT** are mandatory.
- **SHOULD / SHOULD NOT** are strong defaults; departures require a documented reason when consequential.
- **MAY** is optional.
- **PROJECT DECISION** means the owner must decide before implementation depends on it.
- **CONDITIONAL** means apply only when the product actually needs it.
- If requirements conflict, prioritize: safety, security, privacy, data integrity and correctness; platform/accessibility compliance; clarity and recovery; maintainability/testability; reliability/performance; polish; novelty.
- Never infer approval for a new feature, service, dependency, permission, data collection, architecture layer, or product behavior from a vague request.
- Do not fabricate completed work, test results, platform support, or production readiness. Report what was actually inspected and verified.
- Before significant changes, inspect the repository, current conventions, dependency versions, platform configuration, and existing tests. Preserve unrelated work and existing user changes.

## 2. Product scope and fixed stack

### Fixed
- Flutter and Dart.
- Android and iOS only. Do not add web or desktop targets.
- Riverpod for application state; use project-compatible stable APIs, preferring manual `Notifier` and `AsyncNotifier` for mutable/asynchronous state.
- `go_router` for navigation.
- Feature-first organization with pragmatic layers and SOLID principles.
- English and Arabic localization, true LTR/RTL support, and user-visible language switching.
- Light, Dark, and System theme modes; System is the default, and an explicit user choice persists.
- No source-code generation. Do not add `build_runner`, Freezed, `json_serializable`, `riverpod_generator`, Retrofit code generation, Drift code generation, or equivalent generated-source workflows.
- Manual JSON mapping, explicit constructors, `copyWith` where useful, and hand-written Riverpod providers/notifiers.
- Calm, premium-minimal visual direction: considered typography, generous whitespace, restrained white/black/gray neutrals, rounded geometry, subtle separators, purposeful cards, and smooth but restrained motion. Do not imitate default Material styling without deliberate design decisions.

### Not included by default
No backend, authentication, analytics, advertising, monetization, AI service, cloud sync, database, crash-reporting SDK, service locator, feature flag system, or other product capability unless a concrete requirement justifies it and the owner approves consequential choices. Do not add demo/fake production behavior.

## 3. Decisions that require explicit approval

Ask the owner before selecting a consequential option that is not established by this document, including:
- Product requirements, target users, core flows, and success criteria.
- Minimum supported Android/iOS versions, Flutter/Dart SDK policy, and release targets when not specified by the repo.
- Backend/provider, authentication, API contracts, database/storage technology, synchronization and offline semantics.
- Collection, processing, sharing, retention, export, or deletion of personal/sensitive data.
- Permissions, background execution, health/location/camera/microphone/photos/contacts access, and other OS capabilities.
- Third-party SDKs, paid services, licenses with obligations, analytics, crash reporting, remote configuration, and telemetry.
- Signing credentials, release channels, store submission, production deployment, and destructive repository actions.
- Any exception to the fixed stack, especially code generation or adding another state-management/navigation system.

Do not block on trivial reversible details. Make a conservative, consistent choice for low-impact implementation details, explain it briefly, and keep it easy to change.

## 4. Architecture and dependency direction

- Organize by feature first; keep a small, stable shared/core layer for genuine cross-feature concerns.
- Separate presentation, application/state orchestration, domain rules where complexity warrants them, and data/integration code where needed. Do not force every feature into empty layers.
- Dependencies point inward: UI depends on application/domain contracts; domain rules do not depend on Flutter widgets, storage vendors, or network clients.
- Apply SOLID pragmatically. Prefer cohesive, small types and explicit dependencies; avoid god classes/widgets, circular imports, hidden global state, and abstractions with only one trivial implementation unless they protect a meaningful boundary.
- Share a component or abstraction when a real repeated pattern exists. Do not create generic frameworks or premature abstractions.
- Keep public APIs narrow and typed. Use immutable data where practical. Validate input at trust boundaries and keep business rules out of widgets.
- Use explicit names, consistent file organization, predictable error handling, and small reviewable changes.
- Avoid dead code, commented-out implementations, unexplained TODOs, unjustified lint suppressions, and duplicated sources of truth.

Suggested shape (adapt to actual product; do not create empty folders mechanically):
```
lib/
  app/                 # app composition, router, lifecycle integration
  core/
    design_system/     # tokens, themes, shared components
    localization/      # locale setup and hand-maintained localization resources; no generated source
    errors/            # shared error types and presentation mapping
    utilities/         # genuinely shared small utilities
  features/
    <feature>/
      data/            # repositories, data sources, mapping when needed
      domain/          # entities and use cases when complexity warrants
      presentation/    # screens, widgets, feature state
test/
  unit/
  widget/
  integration/
```
Do not introduce layers, folders, or files that do not serve a real need.

## 5. State management

- Use Riverpod only for app state and dependency composition; do not mix competing state-management frameworks.
- Prefer `Notifier` for synchronous mutable state and `AsyncNotifier` for asynchronous state; use `Provider` for derived/dependency values and `StreamProvider` only for genuine streams.
- Keep state ownership and lifetime explicit. Do not place transient field state in global providers without a reason.
- Model loading, success/data, empty, failure, and refresh/retry states intentionally. Avoid ambiguous booleans such as several independent loading/error flags when a state model is clearer.
- Dispose controllers, subscriptions, timers, and resources at the correct lifecycle boundary.
- Guard against stale async results, duplicate submissions, races, and updates after disposal. Cancel work where supported.
- Keep widgets focused on rendering and interaction. Put orchestration in notifiers/application services and core rules in appropriate domain code.
- No generated providers or annotations requiring generated files.

## 6. Navigation and app shell

- Use `go_router`; centralize route definitions and typed parsing/validation of path/query parameters.
- Use named routes where useful. Keep navigation decisions out of unrelated business logic.
- Secondary screens need clear back behavior. Respect Android system back, iOS back gestures, nested navigation, tabs, dialogs/sheets, and unsaved changes.
- Preserve state where users reasonably expect it when switching tabs or returning from a child screen.
- Deep links, authentication redirects, nested shells, and web URL semantics are conditional features, not reasons to add complexity without a requirement.
- Invalid or missing route data must fail safely with a useful recovery path, not crash.

## 7. Design system and visual quality

### Principles
- Premium minimalism, not generic default Material. Design for the task and platform rather than copying either iOS or Material blindly.
- Use whitespace and hierarchy to reduce cognitive load. Avoid clutter, heavy elevation, excessive borders, gradients, neon, glow, decorative noise, and unnecessary ornament.
- Cards are useful grouping surfaces, not a mandatory wrapper for every element.
- Prefer neutral foundations; introduce a product accent only when approved by product requirements.
- Make controls feel native, responsive, and predictable. Prioritize legibility, touchability, and task completion over novelty.

### Tokens
Centralize semantic tokens for:
- Color roles for light/dark surfaces, text, borders/dividers, feedback, and focus.
- Typography roles and weights.
- Spacing (starting scale: 4, 8, 12, 16, 24, 32, 48).
- Radius (starting scale: 8, 12, 16, 24, and pill/full where appropriate).
- Elevation, borders, icon sizes, control heights, motion, and layout constraints where needed.
- Animation duration/curve and reduced-motion behavior.

Use semantic token names rather than scattering raw values. Starting values are references, not permission to duplicate competing token systems. Avoid hardcoded colors/spacing in repeated UI patterns.

### Components
Create shared components only for genuinely repeated patterns or important consistency/accessibility contracts. Consider reusable page scaffolds, section headers, buttons, icon buttons, fields, loading/empty/error states, feedback, dialogs, sheets, snackbars, and selection surfaces when they recur.
Each shared component needs a narrow API, documented variants/states, theme support, localization/RTL behavior, accessibility semantics, appropriate touch targets, and meaningful tests. Do not wrap every standard widget merely to create an abstraction.

### Layout and responsive behavior
- Support small phones, large phones, safe areas, system insets, keyboard/IME, text scaling, and display cutouts.
- Avoid fixed-height text containers and layouts that clip Arabic or scaled text.
- Use constraints and adaptive layouts; do not introduce tablet-specific or large-screen product scope without approval.
- Keep content widths and spacing intentional. Starting max content width around 640 logical pixels is a guideline, not a universal requirement.

### Motion and interaction
- Motion must explain state changes, preserve spatial continuity, and feel quick and controlled.
- Provide visible pressed, focused, disabled, loading, selected, and validation states as applicable.
- Avoid animation that blocks input, harms performance, or exists only as decoration.
- Respect platform conventions and reduced-motion preferences. Never communicate status through color alone.

## 8. Theming, localization, and text

- Support System, Light, and Dark modes. Follow system by default; persist an explicit user override and react correctly when System is selected.
- Use a centralized theme/tokens system. Ensure contrast and component states are intentional in both themes.
- English and Arabic are required. Every user-facing string belongs in localization resources; no hardcoded UI strings in widgets or errors.
- Support real RTL/LTR layouts, including navigation order, alignment, directional icons, gestures, and mixed-direction text. Mirror only icons whose meaning is directional.
- Allow language switching without requiring a restart unless a technical limitation is documented and approved.
- Use locale-aware date, time, number, decimal, currency, and unit formatting. Do not manually concatenate localized sentence fragments.
- Handle mixed Arabic/Latin identifiers, phone numbers, URLs, and numeric values using appropriate bidi isolation and formatting.
- Avoid fixed widths/heights that truncate translations. Test longer strings and text scaling.
- Font selection must support Arabic and Latin glyph coverage and have a compatible license. IBM Plex Sans Arabic may be evaluated but is not mandatory; verify actual rendering and asset/license requirements before adding fonts.

## 9. Accessibility and inclusive design

- Use semantic labels, roles, values, and actions for interactive elements.
- Maintain sufficient contrast in all themes and states; never rely on color alone.
- Respect platform text scaling, screen readers, focus order, keyboard access where relevant, and reduced motion.
- Ensure touch targets are comfortably usable and that controls have clear labels and feedback.
- Announce validation and important asynchronous outcomes accessibly.
- Avoid inaccessible custom controls when a platform widget can meet requirements. Test key flows with accessibility inspection and representative assistive technology when feasible.

## 10. Data, validation, and integrity

- Identify the source of truth for each piece of state. Avoid duplicate mutable copies that can drift.
- Validate data at external boundaries: user input, API responses, local storage, deep links, imported files, and platform callbacks.
- Separate display formatting from canonical values and domain rules.
- Handle null, malformed, missing, out-of-range, and outdated data intentionally.
- Make save/submit outcomes clear. Prevent accidental duplicate actions and protect against partial writes where transactions are available.
- Define deletion, retention, conflict resolution, and recovery behavior before implementing data persistence or sync.
- Never fabricate data or show mock values as if they were real user or server data.

## 11. Persistence, offline use, and migrations

- Storage technology is a PROJECT DECISION unless an existing approved choice is present.
- Persist only what the product needs. Keep secrets and sensitive values out of ordinary preferences and logs.
- Define what survives app restart, process death, logout, upgrade, and device restore.
- Version persisted schemas when change is possible; provide safe migrations and failure recovery before shipping schema changes.
- Offline behavior, caching, sync, conflict resolution, and data freshness must be explicit product decisions; do not imply offline support if it is absent.
- Handle storage failure gracefully and preserve user input when safe and possible.
- Do not add a database or cloud synchronization preemptively.

## 12. Async operations, lifecycle, and errors

- Give asynchronous operations clear loading, success, empty, error, cancellation, timeout, and retry semantics as applicable.
- Distinguish expected validation/business errors from network, storage, permission, and unexpected failures.
- Show concise, actionable user-facing messages; keep technical detail out of user-facing surfaces while retaining safe diagnostic context where approved.
- Retries must be safe, bounded, and appropriate for the operation. Do not blindly retry non-idempotent writes.
- Handle app foreground/background transitions, process death, restored routes/state, permission revocation, connectivity changes, and disposed UI safely.
- Preserve drafts and unsaved work where reasonable. Confirm before destructive or hard-to-reverse actions.
- Avoid unbounded timers, polling, background tasks, and resource use.

## 13. Networking and external integrations (conditional)

- Add networking only when a defined product requirement needs it.
- Define typed request/response contracts, timeouts, cancellation, validation, error mapping, and safe retry rules.
- Treat all external responses as untrusted input. Never expose credentials or private configuration in client code or logs.
- Do not hardcode secrets into the app or commit real tokens, keys, certificates, signing files, or personal data.
- Minimize transmitted data and use secure transport. Define authentication, authorization, expiry, and logout semantics before implementation.
- External SDKs/services require an explicit need, privacy review, license check, maintenance assessment, and owner approval for consequential tradeoffs.

## 14. Security, privacy, and permissions

- Apply least privilege and data minimization. Request a permission only when the user invokes a feature that needs it, with a clear explanation.
- Handle denial, limited access, revocation, and permanent denial without trapping the user. Offer settings navigation only when useful.
- Store secrets only in appropriate secure storage. Never treat obfuscation as secret protection.
- Do not log passwords, tokens, personal identifiers, health data, message contents, raw request bodies, or other sensitive values.
- Avoid unnecessary collection, analytics, tracking, clipboard access, background access, or third-party data sharing.
- Provide clear data deletion/export/retention behavior when relevant to the product and applicable requirements.
- Do not claim legal or regulatory compliance without a verified scope and review.
- Keep debug-only tools and test credentials out of production builds.

## 15. Dependency and supply-chain governance

Before adding a package, check whether the platform/framework already provides the capability, then evaluate maintenance, compatibility, transitive dependencies, license, security, native setup, size, and long-term cost.
- Add the smallest reasonable dependency set. Do not add packages for trivial helpers.
- Keep dependency constraints and lockfiles consistent with the app's policy.
- Review breaking changes and release notes before upgrades. Do not blindly upgrade unrelated packages during a feature change.
- Avoid abandoned, opaque, redundant, or unnecessarily privileged packages.
- Document important native configuration and licensing obligations.
- Generated source/code generation is prohibited under this foundation.

## 16. Performance, memory, and battery

- Prefer simple, measurable solutions over speculative micro-optimization.
- Avoid unnecessary rebuilds, synchronous heavy work on the UI isolate, repeated expensive calculations, and unbounded collections.
- Use lazy lists for large collections, stable keys where appropriate, and efficient image loading/caching.
- Dispose controllers, focus nodes, animations, subscriptions, streams, and other owned resources.
- Avoid unnecessary background execution, polling, wake locks, and battery/network use.
- Profile representative flows in profile/release-like builds before making performance claims.
- Animations must remain smooth under realistic data and device constraints.

## 17. Testing and verification

Testing must match risk and behavior, not just line coverage.
- **Unit tests:** domain rules, parsing/validation, formatters, state transitions, error mapping, and async race/retry behavior.
- **Widget tests:** rendering, user interaction, loading/empty/error/success states, validation, theme, localization, and semantics for important components.
- **Integration tests:** critical end-to-end user journeys, navigation, persistence, and platform integrations where practical.
- **Manual/platform checks:** Android and iOS behavior, back gestures, keyboard/safe areas, permissions, lifecycle, and accessibility.
- Test both Light and Dark themes, English and Arabic, LTR and RTL, text scaling, and representative small-device layouts for important flows.
- Include negative cases: malformed data, unavailable services, permission denial, cancellation, repeated taps, stale responses, and storage failure where relevant.
- Tests must assert meaningful outcomes; do not weaken assertions, skip tests, or mock away the behavior under test merely to get a green result.
- Golden tests are optional and must not become brittle or substitute for behavior/accessibility tests.
- If a platform or environment is unavailable, state exactly what was not verified.

## 18. Code quality and static analysis

Before marking work complete, run the checks available and relevant to the changed code:
- `dart format` (or `dart format --output=none --set-exit-if-changed .` to check formatting).
- `flutter analyze`.
- Relevant unit/widget/integration tests.
- Build checks for affected platforms when the environment and SDKs permit.
- Inspect the final diff for accidental changes, secrets, generated artifacts, dead code, and unrelated edits.
- Do not use `print()` for app logging. Use an approved, privacy-safe logging approach only if the project needs one.
- Fix new warnings and errors introduced by the change. Existing unrelated failures must be reported, not hidden.
- Never claim a check passed unless it actually ran and passed.

## 19. Android and iOS platform correctness

- Keep platform configuration intentional and minimal. Do not add web/desktop folders or claim support for them.
- Respect platform lifecycle, status/navigation bars, safe areas, keyboard behavior, back navigation, permission prompts, and system UI conventions.
- Configure Android manifest permissions and iOS usage descriptions only for approved features that need them.
- Review app identifiers, minimum OS versions, deployment targets, orientation, supported devices, and signing/release configuration as project decisions when unspecified.
- Keep secrets and signing material out of version control. Document safe local/CI configuration without including secret values.
- Verify both platforms when possible; clearly report when only one platform was checked.

## 20. Git, GitHub, CI, and releases

- Inspect branch, status, current changes, remotes, and repository conventions before editing.
- Never overwrite or discard user work, rewrite shared history, force-push, delete branches, change visibility, or perform destructive actions without explicit authorization.
- Use clear, scoped commits and reviewable diffs. Follow the repository's existing branch/PR convention; do not invent mandatory workflow complexity for a solo project.
- Keep secrets out of commits, logs, issue reports, screenshots, and CI output.
- CI should run proportionate quality gates such as formatting, analysis, and tests. Use least-privilege permissions and pinned/reviewed third-party actions where appropriate.
- Do not add CI providers, deployment pipelines, release automation, or signing workflows without considering actual repo capabilities and owner approval.
- Releases require verified versioning, changelog/release notes as appropriate, platform build checks, configuration validation, and explicit authorization to publish or deploy.
- Report commit IDs, branch/PR links, and check outcomes only when confirmed by tool output.

## 21. Documentation

Keep documentation accurate, concise enough to use, and aligned with the actual repository. At minimum, explain:
- Purpose, scope, supported platforms, and non-goals.
- Prerequisites and exact setup/run/test/analyze/build commands.
- Architecture and where to place new code.
- State management, routing, themes, localization, and RTL conventions.
- Configuration and secrets handling without exposing secret values.
- Testing expectations, known limitations, and release steps when applicable.
Do not create multiple overlapping sources of truth. This file governs the foundation; product-specific requirements belong in a separate project specification only when needed.

## 22. AI agent and contributor protocol

For every task:
1. Read this foundation and the relevant project requirements.
2. Inspect the repository and existing implementation before proposing or editing.
3. Summarize the intended scope and identify only consequential unknowns.
4. Ask the owner when a missing decision affects privacy, security, data, architecture, product behavior, dependencies, cost, permissions, or release/destructive actions. Do not ask about details already decided here.
5. Make the smallest coherent change that satisfies the request; avoid unrelated refactors.
6. Follow existing conventions unless they conflict with this foundation; explain any necessary migration.
7. Add or update tests and docs appropriate to the change.
8. Run available checks, inspect the diff, and fix regressions.
9. Report changed files, behavior, tests actually run, results, limitations, and decisions needing owner input.
10. Never say a task is complete when material work remains or validation was not performed.

Agents MUST NOT:
- Invent requirements, APIs, files, repository contents, test results, credentials, or successful deployments.
- Add code generation, packages, permissions, telemetry, backend services, or product capabilities without authorization.
- replace the chosen state-management/router stack or introduce competing systems.
- suppress failures, remove meaningful tests, use fake data as real data, or hide uncertainty.
- perform destructive GitHub/release operations without approval.

## 23. Change control and exceptions

- Record consequential architecture or product decisions in a concise decision record when they affect future work.
- An exception must state the requirement, alternatives considered, measurable benefit, security/privacy implications, maintenance/toolchain cost, test/CI effects, and rollback path.
- Only the project owner can approve changes to fixed requirements. An agent or contributor cannot approve its own exception.
- Keep this foundation consistent when a fixed decision changes; update the source of truth and relevant implementation together.

## 24. Definition of Done

A change is done only when all applicable criteria are met:
- Requirements and observable behavior match the request; no unapproved scope was added.
- Architecture, state, routing, localization, themes, and component conventions are followed.
- Android/iOS behavior and RTL/LTR behavior are correct for affected flows.
- Loading, empty, success, failure, retry, validation, and recovery states are handled as relevant.
- Accessibility, text scaling, safe areas, keyboard behavior, and reduced motion have been considered.
- Data integrity, privacy, permissions, and security boundaries are respected.
- Meaningful tests and documentation are updated.
- Formatting, analysis, tests, and relevant build checks have run where available; unverified checks are explicitly disclosed.
- The final diff is reviewed and contains no accidental files, secrets, generated source, or unrelated changes.
- The completion report is factual and lists any remaining risk or limitation.

## 25. Final checklist

Before implementation:
- [ ] Read this foundation and project-specific requirements.
- [ ] Inspect repository, SDK constraints, current architecture, dependencies, and tests.
- [ ] Resolve consequential unknowns with the owner.
- [ ] Confirm the change fits Android/iOS-only scope and fixed stack.

Before completion:
- [ ] Requirements met; no unapproved feature or dependency.
- [ ] Error, empty, loading, recovery, lifecycle, and validation states considered.
- [ ] Theme, Arabic/English, RTL/LTR, accessibility, and text scaling checked as relevant.
- [ ] Privacy, permissions, data integrity, and secure logging reviewed.
- [ ] Tests and docs updated; formatting/analyze/tests/build checks run as available.
- [ ] Diff reviewed; no secrets, generated code, or unrelated edits.
- [ ] Report exactly what changed and what was actually verified.

## 26. Guiding principle

Build software that is calm to use, predictable, accessible, secure, maintainable, and honest about its behavior. Prefer clarity over cleverness, consistency over novelty, and verified correctness over claims. Do not optimize for looking sophisticated at the expense of solving the user's actual problem.
