import 'package:esme26/domain/models/user.dart';
import 'package:esme26/domain/onboarding/onboarding_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OnboardingFlow flow;

  setUp(() => flow = OnboardingFlow());

  void fillLocation() {
    flow.city = 'Paris';
    flow.postalCode = '75001';
  }

  test('Artisan transitions follow role, trade, location, KYC, home', () {
    expect(flow.step, OnboardingStep.role);
    expect(flow.canGoBack, isFalse);
    expect(flow.next, throwsStateError);
    expect(flow.back, throwsStateError);
    flow.chooseRole(UserRole.artisan);
    expect(flow.steps, [
      OnboardingStep.role,
      OnboardingStep.trade,
      OnboardingStep.location,
      OnboardingStep.kyc,
    ]);
    expect(flow.stepNumber, 2);
    expect(flow.next, throwsStateError);
    flow.trade = '   ';
    expect(flow.next, throwsStateError);
    flow.trade = 'Menuisier';
    flow.next();
    expect(flow.step, OnboardingStep.location);
    expect(flow.next, throwsStateError);
    fillLocation();
    flow.country = ' ';
    expect(flow.next, throwsStateError);
    flow.country = 'France';
    flow.next();
    expect(flow.step, OnboardingStep.kyc);
    expect(flow.next, throwsStateError);
    flow.completeKyc();
    expect(flow.step, OnboardingStep.completed);
    expect(flow.canGoBack, isFalse);
    expect(flow.back, throwsStateError);
    expect(flow.next, throwsStateError);
  });

  test('Customer requires interests, name and location, without KYC', () {
    flow.chooseRole(UserRole.customer);
    expect(flow.steps, [
      OnboardingStep.role,
      OnboardingStep.interests,
      OnboardingStep.name,
      OnboardingStep.location,
    ]);
    expect(flow.next, throwsStateError);
    flow.toggleInterest('Bois');
    flow.toggleInterest('Bois');
    expect(flow.interests, isEmpty);
    flow.toggleInterest('Bois');
    expect(() => flow.interests.add('Textile'), throwsUnsupportedError);
    flow.next();
    expect(flow.step, OnboardingStep.name);
    expect(flow.next, throwsStateError);
    flow.firstName = 'Camille';
    expect(flow.next, throwsStateError);
    flow.lastName = 'Martin';
    flow.next();
    expect(flow.completeKyc, throwsStateError);
    fillLocation();
    flow.next();
    expect(flow.step, OnboardingStep.completed);
  });

  test('Back preserves draft; changing role clears branch-specific fields', () {
    flow.chooseRole(UserRole.customer);
    flow.toggleInterest('Bois');
    flow.next();
    flow.firstName = 'Camille';
    flow.back();
    expect(flow.interests, {'Bois'});
    flow.back();
    flow.chooseRole(UserRole.customer);
    expect(flow.firstName, 'Camille');
    expect(flow.interests, {'Bois'});
    flow.back();
    flow.chooseRole(UserRole.artisan);
    expect(flow.firstName, isEmpty);
    expect(flow.interests, isEmpty);
    flow.trade = 'Potier';
    flow.next();
    fillLocation();
    flow.back();
    expect(flow.trade, 'Potier');
    expect(flow.city, 'Paris');
    flow.back();
    flow.chooseRole(UserRole.customer);
    expect(flow.trade, isEmpty);
    expect(flow.city, 'Paris');
  });

  test('Branch changes and KYC cannot skip steps', () {
    expect(flow.completeKyc, throwsStateError);
    flow.chooseRole(UserRole.artisan);
    expect(() => flow.chooseRole(UserRole.customer), throwsStateError);
    expect(() => flow.toggleInterest('Bois'), throwsStateError);
    expect(flow.completeKyc, throwsStateError);
  });
}
