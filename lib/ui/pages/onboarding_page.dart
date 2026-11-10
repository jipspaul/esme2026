import 'package:esme26/application/onboarding_controller.dart';
import 'package:esme26/data/repositories/kyc_repository.dart' as data;
import 'package:esme26/domain/repositories/kyc_repository.dart';
import 'package:esme26/ui/pages/home_page.dart';
import 'package:esme26/ui/widgets/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  final KycRepository? kycRepository;

  const OnboardingPage({super.key, this.kycRepository});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OnboardingController(kycRepository: widget.kycRepository ?? data.KycRepository.instance);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) =>
          _controller.isCompleted ? HomePage(role: _controller.role!, firstName: _controller.firstName) : OnboardingView(controller: _controller),
    );
  }
}
