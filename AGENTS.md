# AGENTS.md — esme26

Flutter app (package name `esme26`, Dart SDK `^3.13.1`) currently implementing a user onboarding/enrollment flow.

## Commands

```bash
flutter pub get                                   # install dependencies
flutter run                                       # run on the selected device
flutter analyze                                   # lint (flutter_lints via analysis_options.yaml)
dart format lib test                              # format
flutter test                                      # all tests
flutter test test/widget_test.dart                # single test file
flutter test --plain-name "Counter increments"    # single test by name
```

`test/widget_test.dart` is still the default Flutter counter template and does not match the current UI (no counter / `+` button), so it fails until rewritten.

## Architecture

Code under `lib/` follows a layered layout (some layers are placeholders with only `.gitkeep`):

- `lib/data/models/` — plain immutable data classes (`final` fields, named `required` constructor params). `User` composes an `Adress`.
- `lib/data/repositories/` — reserved for data access (empty).
- `lib/domain/` — reserved for business logic (empty).
- `lib/ui/pages/` — reserved for full-screen pages (empty; `MyHomePage` currently lives in `lib/main.dart`).
- `lib/ui/widgets/` — reusable widgets, e.g. `OnboardingFormWidget`.

Data flow: `OnboardingFormWidget` owns `TextEditingController`s for each field, builds an `Adress` + `User` on "Enroll", and hands it up via the `userCallback(User)` constructor callback. `MyHomePage` (in `main.dart`) stores the `User` and, via `setState`, swaps the form for a confirmation `Text`. There is no state-management package or persistence yet — state is passed through constructor callbacks.

## Conventions

- Use package imports (`package:esme26/...`), not relative imports.
- The address class/file/field is spelled `Adress` / `adress.dart` / `user.adress` throughout — keep that spelling consistent when referencing it rather than introducing `Address`.
- Birth dates are stored as an `int` epoch in `User.birthDateInMillisFromEpoch`, parsed from a `YYYY-MM-DD` text field. Note the form currently uses `microsecondsSinceEpoch`, which mismatches the field name.
- Dart dot-shorthand syntax is used (e.g. `colorScheme: .fromSeed(...)`), which relies on the recent SDK constraint.
- Platform folders (`android/`, `ios/`, `web/`, `macos/`, `linux/`, `windows/`) and `build/` are excluded from analysis; app code lives only in `lib/`.
