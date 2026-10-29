# Flutter scaffold status

The repository includes the first application-level foundation slice: a Dart entry point, Riverpod preferences state, a go_router route, a monochrome theme/token layer, reusable AppPage/AppCard/SectionHeader components, hand-maintained English/Arabic localization, a foundation showcase screen, widget tests, and a GitHub Actions quality workflow.

## Toolchain baseline

The manifest targets Dart 3.12 or newer and uses the stable package lines flutter_riverpod 3.4.x and go_router 18.x. Theme and language preferences are stored locally with shared_preferences; no account or network service is involved. Use a compatible stable Flutter SDK and commit the resolved pubspec.lock for this application.

## Important limitations and decisions

- Localization strings are hand-maintained to honor the no-generated-source rule.
- The repository still needs the native Android and iOS runner/project files produced and reviewed with a compatible Flutter SDK.
- Choose and record the application identifier (Android application ID / iOS bundle identifier) before generating native platform folders. Do not silently invent a release-facing identifier.
- No pubspec.lock has been generated and committed yet.
- This scaffold is a foundation showcase, not a finished consumer product. Replace the showcase screen with actual product requirements rather than accumulating demo UI.

## Quality workflow

The GitHub Actions workflow at .github/workflows/flutter-quality.yml runs dependency resolution, formatting checks, static analysis, and tests. Its status must be checked on GitHub for the current commit; do not claim a workflow or tests pass merely because the workflow file exists.

## First verification on a machine with Flutter installed

Run these commands from the repository root:

    flutter --version
    flutter pub get
    dart format --output=none --set-exit-if-changed lib test
    flutter analyze --fatal-infos
    flutter test --reporter expanded

Once native runner folders exist, validate Android and iOS builds on supported toolchains. Commit the resolved dependency lockfile; do not commit build output or generated source files.
