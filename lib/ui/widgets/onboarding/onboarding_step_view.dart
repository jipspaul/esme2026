import 'package:esme26/application/onboarding_controller.dart';
import 'package:esme26/domain/onboarding/onboarding_flow.dart';
import 'package:esme26/ui/widgets/onboarding/interests_step.dart';
import 'package:esme26/ui/widgets/onboarding/kyc_step.dart';
import 'package:esme26/ui/widgets/onboarding/location_step.dart';
import 'package:esme26/ui/widgets/onboarding/name_step.dart';
import 'package:esme26/ui/widgets/onboarding/role_step.dart';
import 'package:esme26/ui/widgets/onboarding/trade_step.dart';
import 'package:flutter/material.dart';

class OnboardingStepView extends StatelessWidget {
  final OnboardingController controller;

  const OnboardingStepView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return switch (controller.step) {
      OnboardingStep.role => RoleStep(onSelected: controller.chooseRole),
      OnboardingStep.trade => TradeStep(initialValue: controller.trade, onChanged: controller.updateTrade, onNext: controller.next),
      OnboardingStep.interests => InterestsStep(selected: controller.interests, onToggle: controller.toggleInterest, onNext: controller.next),
      OnboardingStep.name => NameStep(
        firstName: controller.firstName,
        lastName: controller.lastName,
        onFirstNameChanged: controller.updateFirstName,
        onLastNameChanged: controller.updateLastName,
        onNext: controller.next,
      ),
      OnboardingStep.location => LocationStep(
        city: controller.city,
        postalCode: controller.postalCode,
        country: controller.country,
        onCityChanged: controller.updateCity,
        onPostalCodeChanged: controller.updatePostalCode,
        onCountryChanged: controller.updateCountry,
        onNext: controller.next,
      ),
      OnboardingStep.kyc => KycStep(
        busy: controller.isVerifying,
        rejected: controller.kycStatus == KycStatus.rejected,
        error: controller.kycError,
        onVerify: controller.verifyIdentity,
      ),
      OnboardingStep.completed => throw StateError('Onboarding already completed.'),
    };
  }
}
