# Flutter scaffold status

The repository now includes the first application-level foundation slice: a Dart entry point, Riverpod preferences state, a go_router route, a monochrome theme/token layer, hand-maintained English/Arabic localization, a foundation showcase screen, widget tests, and a GitHub Actions quality workflow.

## Toolchain baseline

The manifest targets Dart 3.12 or newer and uses the stable package lines flutter_riverpod 3.4.x and go_router 18.x. Use a compatible stable Flutter SDK and commit the resolved pubspec.lock for this application.

## Important limitations and decisions

- Theme and language choices are currently in-memory only. Persistence intentionally waits for an explicit storage decision; do not imply preferences survive process restart yet.
- Localization strings are hand-maintained to honor the no-generated-source rule.
- The repository still needs the native Android and iOS runner/project files produced and reviewed with a compatible Flutter SDK.
- Choose and record the application identifier (Android application ID / iOS bundle identifier) before generating native platform folders. Do not silently invent a release-facing identifier.
- No pubspec.lock has been generated or committed yet.
- This scaffold is a foundation showcase, not a finished consumer product. Replace the showcase screen with actual product requirements rather than accumulating demo UI.

## Quality workflow

The GitHub Actions workflow at `.github/workflows/flutter-quality.yml` is configured to run dependency resolution, formatting checks, static analysis, and tests. Its status must be checked on GitHub; do not claim the workflow or tests pass merely because the workflow file exists. GitHub may not run a newly introduced pull-request workflow until the workflow is present on the base branch.

## First verification on a machine with Flutter installed

Run these commands from the repository root:

    flutter --version
    flutter pub get
    dart format --output=none --set-exit-if-changed lib test
    flutter analyze --fatal-infos
    flutter test --reporter expanded

Once native runner folders exist, validate Android and iOS builds on supported toolchains. Commit the resolved dependency lockfile; do not commit build output or generated source files.
