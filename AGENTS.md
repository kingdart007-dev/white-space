# Instructions for AI Agents and Contributors

This repository's binding engineering and product baseline is `FOUNDATION.md`. Read it before making plans or changes. If a user request conflicts with a fixed requirement, do not silently override the foundation: explain the conflict and request explicit owner approval.

## Required workflow

1. Read `FOUNDATION.md` and this file, then inspect the current repository state, relevant files, history/conventions, and available tooling before editing.
2. Identify the requested outcome and keep the change limited to that outcome. Do not repeat questions already answered by the foundation.
3. Ask before consequential decisions involving product behavior, personal/sensitive data, security, permissions, backend/storage/network providers, dependencies, licensing/cost, architecture exceptions, releases, or destructive actions. For low-impact reversible details, choose a conservative option and document it when useful.
4. Make the smallest coherent, reviewable change. Preserve unrelated user changes; never reset, overwrite, or remove work just to simplify the task.
5. Follow the fixed stack: Flutter/Dart for Android and iOS only, Riverpod with manually written providers/notifiers, `go_router`, English and Arabic with real RTL/LTR, System/Light/Dark themes, and no source-code generation or Freezed.
6. Do not add web/desktop targets, new state-management/router systems, backend/auth/analytics/AI/cloud sync/database features, permissions, telemetry, or third-party packages without a real requirement and required approval.
7. Add/update meaningful tests and documentation when implementation exists and the change warrants them. Do not create empty scaffolding or infrastructure solely to make the repository look larger.
8. Run the checks relevant to the changed files using tools actually available. Inspect the final diff and check for secrets, accidental/generated files, unrelated changes, and misleading documentation.
9. Report the files changed, behavior affected, commands/checks actually run and their outcomes, anything not verified, and any decisions still requiring owner input.

## Truthfulness and safety

- Never claim a build, test, analysis, security review, deployment, or platform behavior was verified unless it actually was.
- Never fabricate repository files, APIs, dependency versions, test results, credentials, or external-service behavior.
- Never commit secrets, signing material, personal data, or sensitive logs.
- Never weaken/remove meaningful tests, suppress failures, or use mock/demo values as real product data merely to obtain a green check.
- Never force-push, rewrite shared history, delete branches/files, change repository visibility, publish releases, or deploy without explicit authorization.
- Do not introduce generated source or code-generation tooling under the current fixed baseline.
- Keep comments and documentation factual and synchronized with the actual implementation.

## Repository-specific note

This repository contains a foundation specification and an early Flutter source scaffold. Inspect the current files and toolchain before running Flutter commands or adding CI. The native Android/iOS runner folders and resolved dependency lockfile may still be absent; do not claim device builds or tests have passed without actually running them. Keep CI proportionate and avoid workflows that fail solely because native platform scaffolding has not yet been generated.
