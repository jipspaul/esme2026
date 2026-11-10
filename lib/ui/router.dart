import 'package:esme26/domain/models/models.dart';
import 'package:esme26/domain/repositories/kyc_repository.dart';
import 'package:esme26/ui/pages/home_page.dart';
import 'package:esme26/ui/pages/onboarding_page.dart';
import 'package:esme26/ui/widgets/app_shell.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter({
  required ValueNotifier<bool> darkMode,
  required VoidCallback onToggleDarkMode,
  KycRepository? kycRepository,
}) {
  return GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(
          title: state.uri.path == '/homepage'
              ? 'Accueil'
              : 'Faisons connaissance',
          darkMode: darkMode,
          onToggleDarkMode: onToggleDarkMode,
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) =>
                OnboardingPage(kycRepository: kycRepository),
          ),
          GoRoute(
            path: '/homepage',
            builder: (context, state) {
              if (state.extra case (
                role: UserRole role,
                firstName: String firstName,
              )) {
                return HomePage(role: role, firstName: firstName);
              }

              return HomePage(role: UserRole.customer, firstName: 'John Doe');
            },
          ),
        ],
      ),
    ],
  );
}
