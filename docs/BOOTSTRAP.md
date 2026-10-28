# Flutter scaffold status

The repository now includes the first application-level foundation slice: a Dart entry point, Riverpod preferences state, a go_router route, a monochrome theme/token layer, manual English/Arabic localization, and widget tests.

## Toolchain baseline

The manifest targets Dart 3.12 or newer and uses the stable package lines flutter_riverpod 3.4.x and go_router 18.x. Use a compatible stable Flutter SDK and commit the resolved pubspec.lock for this application.

## Important limitations

- Theme and language choices are currently in-memory only. Persistence intentionally waits for an explicit storage decision; do not imply preferences survive process restart yet.
- Localization strings are hand-maintained to honor the no-generated-source rule.
- The repository still needs the native Android and iOS runner/project files produced and reviewed with a compatible Flutter SDK. Do not claim device builds or native runtime behavior are verified until that work has happened.
- This scaffold is a foundation showcase, not a finished consumer product. Replace the showcase screen with actual product requirements rather than accumulating demo UI.

## First verification on a machine with Flutter installed

Run these commands from the repository root:

    flutter --version
    flutter pub get
    dart format --output=none --set-exit-if-changed lib test
    flutter analyze
    flutter test

Once native runner folders exist, validate Android and iOS builds on the supported toolchains. Commit the generated dependency lockfile; do not commit build output or generated source files.
