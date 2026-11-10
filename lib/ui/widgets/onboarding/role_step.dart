import 'package:esme26/domain/models/user.dart';
import 'package:flutter/material.dart';

class RoleStep extends StatelessWidget {
  final ValueChanged<UserRole> onSelected;

  const RoleStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Bienvenue !', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Comment souhaitez-vous utiliser notre application ?',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        _RoleCard(
          icon: Icons.handyman_outlined,
          title: 'Je suis artisan',
          description: 'Faites découvrir votre métier et votre savoir-faire.',
          onTap: () => onSelected(UserRole.artisan),
        ),
        const SizedBox(height: 16),
        _RoleCard(
          icon: Icons.home_outlined,
          title: 'Je suis particulier',
          description: 'Trouvez des artisans pour donner vie à vos projets.',
          onTap: () => onSelected(UserRole.customer),
        ),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(description, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
