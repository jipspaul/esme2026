import 'package:esme26/application/onboarding_controller.dart';
import 'package:esme26/ui/widgets/onboarding/onboarding_step_view.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  final OnboardingController controller;

  const OnboardingView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: controller.isChoosingRole,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) controller.requestBack();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Faisons connaissance'),
          leading: controller.isChoosingRole
              ? null
              : IconButton(
                  tooltip: 'Retour',
                  onPressed: controller.canGoBack
                      ? controller.requestBack
                      : null,
                  icon: const Icon(Icons.arrow_back),
                ),
        ),
        body: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  if (controller.isChoosingRole)
                    const Text('Votre profil')
                  else ...[
                    Text(
                      'Étape ${controller.stepNumber} sur ${controller.stepCount}',
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: controller.progress),
                  ],
                  const SizedBox(height: 32),
                  OnboardingStepView(controller: controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
