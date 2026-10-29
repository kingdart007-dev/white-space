# White Space

A premium-minimal Flutter foundation for maintainable Android and iOS apps.

## Start here

1. **[FOUNDATION.md](FOUNDATION.md)** — the binding product, design, architecture, security, accessibility, and quality standard.
2. **[AGENTS.md](AGENTS.md)** — the required AI-agent and contributor workflow.
3. **[docs/BOOTSTRAP.md](docs/BOOTSTRAP.md)** — scaffold status, toolchain expectations, limitations, and first verification commands.

## Fixed baseline

- Flutter and Dart; Android and iOS only
- Riverpod with manually written providers and notifiers
- go_router for navigation
- No source-code generation or Freezed
- English and Arabic with real RTL/LTR support
- System, Light, and Dark themes
- Neutral monochrome design tokens, generous whitespace, purposeful rounded surfaces, and restrained motion
- Security, accessibility, testability, maintainability, and truthful verification are requirements

## Current implementation

The initial Flutter source scaffold is available on the feature branch. It includes the app entry point, a single go_router route, Riverpod-managed theme/language preferences persisted with shared_preferences, a monochrome theme, manual English/Arabic strings, reusable AppPage/AppCard/SectionHeader components, a foundation showcase screen, widget tests, and a GitHub Actions workflow for formatting, analysis, and tests. The workflow status must be checked on GitHub for each relevant commit.

This is an early foundation slice, not a finished product. Native Android/iOS runner folders and a resolved dependency lockfile have not yet been generated and committed. Do not treat platform builds as passing until they are run with compatible Android and iOS toolchains.

## Working rule

Do not guess consequential product, data, privacy, security, dependency, permission, storage, or release decisions. Ask the project owner when a decision is genuinely required. Do not add features or infrastructure just because they are common.
