import 'dart:async';

import 'package:esme26/application/onboarding_controller.dart';
import 'package:esme26/domain/models/user.dart';
import 'package:esme26/domain/onboarding/onboarding_flow.dart';
import 'package:esme26/domain/repositories/kyc_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _KycRepository repository;
  late OnboardingController controller;

  setUp(() {
    repository = _KycRepository();
    controller = OnboardingController(kycRepository: repository);
  });

  tearDown(() => controller.dispose());

  void reachKyc() {
    controller.chooseRole(UserRole.artisan);
    controller.updateTrade('Menuisier');
    controller.next();
    controller.updateCity('Paris');
    controller.updatePostalCode('75001');
    controller.next();
  }

  test('Controller drives customer flow independently of widgets', () {
    var notifications = 0;
    controller.addListener(() => notifications++);
    expect(controller.requestBack(), isFalse);
    controller.chooseRole(UserRole.customer);
    expect(controller.stepCount, 4);
    controller.toggleInterest('Bois');
    controller.next();
    controller.updateFirstName('Camille');
    controller.updateLastName('Martin');
    controller.next();
    expect(controller.requestBack(), isTrue);
    expect(controller.firstName, 'Camille');
    controller.next();
    controller.updateCity('Paris');
    controller.updatePostalCode('75001');
    controller.updateCountry('France');
    controller.next();
    expect(controller.isCompleted, isTrue);
    expect(controller.requestBack(), isFalse);
    expect(notifications, 7);
    expect(repository.calls, 0);
  });

  test('KYC blocks back and duplicate requests until approval', () async {
    reachKyc();
    final pending = controller.verifyIdentity();
    expect(controller.isVerifying, isTrue);
    expect(controller.requestBack(), isFalse);
    await controller.verifyIdentity();
    expect(repository.calls, 1);
    repository.request.complete(KycResult.approved);
    await pending;
    expect(controller.isCompleted, isTrue);
    expect(controller.isVerifying, isFalse);
  });

  test(
    'Rejection and typed errors permit retries without completing',
    () async {
      reachKyc();
      var pending = controller.verifyIdentity();
      repository.request.complete(KycResult.rejected);
      await pending;
      expect(controller.kycStatus, KycStatus.rejected);
      expect(controller.step, OnboardingStep.kyc);

      pending = controller.verifyIdentity();
      repository.request.completeError(const KycException('Unavailable'));
      await pending;
      expect(controller.kycStatus, KycStatus.failed);
      expect(controller.kycError, 'Unavailable');
      expect(controller.canGoBack, isTrue);

      pending = controller.verifyIdentity();
      expect(controller.kycError, isNull);
      repository.request.complete(KycResult.approved);
      await pending;
      expect(controller.isCompleted, isTrue);
    },
  );

  test('Leaving KYC clears its error', () async {
    reachKyc();
    final pending = controller.verifyIdentity();
    repository.request.complete(KycResult.rejected);
    await pending;
    controller.requestBack();
    expect(controller.kycStatus, KycStatus.idle);
    expect(controller.step, OnboardingStep.location);
  });

  test('Verification cannot be requested outside KYC', () async {
    await expectLater(controller.verifyIdentity(), throwsStateError);
    expect(repository.calls, 0);
  });

  test('Unexpected failures propagate and release the busy state', () async {
    reachKyc();
    final pending = controller.verifyIdentity();
    final expectation = expectLater(pending, throwsStateError);
    repository.request.completeError(StateError('Unexpected'));
    await expectation;
    expect(controller.isVerifying, isFalse);
    expect(controller.isCompleted, isFalse);
  });

  test('Disposed controllers ignore late KYC results', () async {
    final disposable = OnboardingController(kycRepository: repository);
    disposable.chooseRole(UserRole.artisan);
    disposable.updateTrade('Potier');
    disposable.next();
    disposable.updateCity('Lyon');
    disposable.updatePostalCode('69001');
    disposable.next();
    final pending = disposable.verifyIdentity();
    disposable.dispose();
    repository.request.complete(KycResult.approved);
    await pending;
    expect(disposable.isCompleted, isFalse);
  });
}

class _KycRepository implements KycRepository {
  int calls = 0;
  late Completer<KycResult> request;

  @override
  Future<KycResult> verify() {
    calls++;
    request = Completer<KycResult>();
    return request.future;
  }
}
