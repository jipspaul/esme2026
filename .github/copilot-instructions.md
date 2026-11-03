# Copilot instructions — esme26

Flutter application (`esme26`, Dart SDK `^3.13.1`) with an onboarding flow and
domain models for a home-services marketplace. See the [README](../README.md)
for model relationships, validation rules, repository behavior, and mock-data
details.

## Build, test, and lint

```bash
flutter pub get
flutter run
flutter analyze
dart format lib test
flutter test
flutter test test/widget_test.dart
flutter test test/widget_test.dart --plain-name "Customer flow validates fields and reaches home without KYC"
```

For focused domain or application changes, run the matching tests under
`test/domain/` or `test/application/`; repository tests are under
`test/data/repositories/`.

## Architecture

- `lib/main.dart` launches `OnboardingPage`. The page owns the
  `OnboardingController` lifecycle, injects a KYC repository, and switches to
  `HomePage` when onboarding completes.
- `lib/application/onboarding_controller.dart` coordinates the domain
  `OnboardingFlow`, draft inputs, notifications, and asynchronous KYC results.
  `lib/domain/onboarding/onboarding_flow.dart` is the Dart-only state machine
  for role-specific steps, validation, and back navigation.
- `lib/ui/pages/` composes pages and manages controller lifecycle.
  `lib/ui/widgets/onboarding/` contains the view and a dedicated widget for
  each step. Widgets render state and forward actions; keep transitions,
  branching, repository access, and async orchestration out of UI widgets.
- `lib/domain/models/` contains framework-independent entities and value
  objects; `lib/domain/repositories/` defines contracts. `lib/data/repositories/`
  provides data-layer facades and mock implementations, seeded by
  `lib/data/mocks/mock_data.dart`. These repositories are in-memory, not
  persistent. `lib/data/models/` re-exports legacy model imports.

## Repository-specific conventions

- Keep the domain independent of Flutter and the data layer. Depend on domain
  repository interfaces and inject them where behavior needs a repository.
  Data-layer `XRepository.instance` facades and `XRepositoryImpl` factories
  share their singleton implementation; the in-memory implementations expose
  `reset()` for test isolation.
- Domain models use immutable fields and defensively copied collections.
  Validate model invariants in the constructors; see the README for important
  monetary, date, and relationship rules.
- Use package imports (`package:esme26/...`), not relative imports.
- Preserve the established `Adress` spelling (`adress.dart`, `user.adress`)
  for compatibility; do not introduce a parallel `Address` model.
- `User.birthDateInMillisFromEpoch` is in milliseconds. Use Dart dot-shorthand
  where already established; the SDK constraint supports it.
- The default onboarding KYC repository is a demo mock, not identity
  verification. Keep it injectable for tests and do not treat mock approval as
  a verified account or artisan status.
