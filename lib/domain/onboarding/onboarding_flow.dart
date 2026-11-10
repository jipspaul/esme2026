import 'package:esme26/domain/models/user.dart';

enum OnboardingStep { role, trade, interests, name, location, kyc, completed }

class OnboardingFlow {
  OnboardingStep _step = OnboardingStep.role;
  UserRole? _role;
  String trade = '';
  Set<String> _interests = {};
  String firstName = '';
  String lastName = '';
  String city = '';
  String postalCode = '';
  String country = 'France';

  OnboardingStep get step => _step;
  UserRole? get role => _role;
  Set<String> get interests => Set.unmodifiable(_interests);

  List<OnboardingStep> get steps => [
    OnboardingStep.role,
    if (_role == UserRole.artisan) OnboardingStep.trade,
    if (_role == UserRole.customer) ...[OnboardingStep.interests, OnboardingStep.name],
    if (_role != null) OnboardingStep.location,
    if (_role == UserRole.artisan) OnboardingStep.kyc,
  ];

  int get stepNumber => steps.indexOf(_step) + 1;
  bool get canGoBack => _step != OnboardingStep.role && _step != OnboardingStep.completed;

  void chooseRole(UserRole role) {
    _requireStep(OnboardingStep.role);
    if (_role != role) {
      trade = '';
      _interests = {};
      firstName = '';
      lastName = '';
    }
    _role = role;
    _step = steps[1];
  }

  void toggleInterest(String interest) {
    _requireStep(OnboardingStep.interests);
    if (!_interests.remove(interest)) {
      _interests.add(interest);
    }
  }

  void next() {
    final valid = switch (_step) {
      OnboardingStep.trade => trade.trim().isNotEmpty,
      OnboardingStep.interests => _interests.isNotEmpty,
      OnboardingStep.name => firstName.trim().isNotEmpty && lastName.trim().isNotEmpty,
      OnboardingStep.location => city.trim().isNotEmpty && postalCode.trim().isNotEmpty && country.trim().isNotEmpty,
      _ => false,
    };
    if (!valid) {
      throw StateError('Cannot advance from $_step with incomplete data.');
    }
    final index = steps.indexOf(_step);
    _step = index + 1 < steps.length ? steps[index + 1] : OnboardingStep.completed;
  }

  void completeKyc() {
    _requireStep(OnboardingStep.kyc);
    _step = OnboardingStep.completed;
  }

  void back() {
    if (!canGoBack) {
      throw StateError('Cannot go back from $_step.');
    }
    _step = steps[steps.indexOf(_step) - 1];
  }

  void _requireStep(OnboardingStep expected) {
    if (_step != expected) {
      throw StateError('Expected $expected, got $_step.');
    }
  }
}
