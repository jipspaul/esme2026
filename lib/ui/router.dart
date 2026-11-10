import 'package:esme26/domain/models/models.dart';
import 'package:esme26/domain/repositories/kyc_repository.dart';
import 'package:esme26/ui/pages/home_page.dart';
import 'package:esme26/ui/pages/onboarding_page.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter({KycRepository? kycRepository}) {
  return GoRouter(
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

          UserRole role = UserRole.customer;
          String firstName = 'John Doe';
          return HomePage(role: role, firstName: firstName);
        },
      ),
    ],
  );
}
