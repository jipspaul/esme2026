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

`test/widget_test.dart` exercises the onboarding flows, validation and KYC retries.

## Architecture

Code under `lib/` follows a layered layout:

- `lib/data/models/` — compatibility exports for domain models.
- `lib/data/repositories/` — singleton facades and mock implementations.
- `lib/domain/` — pure Dart models, repository interfaces and onboarding state machine.
- `lib/application/` — controllers coordinating domain transitions and repositories.
- `lib/ui/pages/` — page composition and controller lifecycle.
- `lib/ui/widgets/` — dedicated presentation widgets.

Data flow: `OnboardingController` owns the domain `OnboardingFlow`, draft inputs
and asynchronous KYC orchestration. Widgets observe notifications and forward
user actions. Onboarding state is in memory only, without persistence.

## UI separation of concerns

- Use dedicated widget classes rather than widget-returning helper methods such
  as `_buildStep`. Construct UI in each widget's `build` method.
- Keep state-machine transitions, branching rules, repository calls and async
  orchestration outside the UI. Controllers coordinate the domain; widgets only
  render state, perform form presentation/validation and forward actions.
- Follow the repository interface + singleton facade + implementation pattern.

## Conventions

- Use package imports (`package:esme26/...`), not relative imports.
- The address class/file/field is spelled `Adress` / `adress.dart` / `user.adress` throughout — keep that spelling consistent when referencing it rather than introducing `Address`.
- Birth dates are stored as an `int` epoch in milliseconds in `User.birthDateInMillisFromEpoch`.
- Dart dot-shorthand syntax is used (e.g. `colorScheme: .fromSeed(...)`), which relies on the recent SDK constraint.
- Platform folders (`android/`, `ios/`, `web/`, `macos/`, `linux/`, `windows/`) and `build/` are excluded from analysis; app code lives only in `lib/`.
