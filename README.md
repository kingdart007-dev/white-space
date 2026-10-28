# White Space

A single, practical source of truth for building polished, maintainable Flutter apps for Android and iOS.

## Start here

1. Read **[FOUNDATION.md](FOUNDATION.md)** before planning or implementing work. It defines the fixed technology choices, architecture and design principles, localization and accessibility requirements, security and data rules, testing expectations, workflow, and definition of done.
2. Read **[AGENTS.md](AGENTS.md)** for the required workflow and safety rules for AI agents and contributors.

## Fixed baseline

- Flutter and Dart; Android and iOS only
- Riverpod for state management, using manually written providers and notifiers
- `go_router` for navigation
- No source-code generation or Freezed
- Arabic and English with real RTL/LTR support
- System, Light, and Dark themes
- Premium-minimal visual direction: neutral palette, generous whitespace, purposeful rounded surfaces, and restrained motion
- Security, accessibility, testability, maintainability, and truthful verification are requirements—not optional polish

## Working rule

Do not guess consequential product, data, privacy, security, dependency, permission, or release decisions. Ask the project owner when a decision is genuinely required. Do not add features or infrastructure just because they are common.

## Scope and current status

This repository currently contains the foundation specification and contributor instructions. It is not yet represented as a runnable Flutter application. Application code, Flutter CI, platform builds, and runtime behavior must not be described as implemented or tested unless they are subsequently added and verified.
