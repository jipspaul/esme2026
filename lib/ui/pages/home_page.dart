import 'package:esme26/domain/models/user.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final UserRole role;
  final String firstName;

  const HomePage({super.key, required this.role, required this.firstName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              role == UserRole.artisan
                  ? Icons.handyman_outlined
                  : Icons.home_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              firstName.trim().isEmpty
                  ? 'Bienvenue dans votre espace artisan !'
                  : 'Bienvenue ${firstName.trim()} !',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Votre parcours de découverte est terminé.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
