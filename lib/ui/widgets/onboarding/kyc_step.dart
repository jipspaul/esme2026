import 'package:flutter/material.dart';

class KycStep extends StatelessWidget {
  final bool busy;
  final bool rejected;
  final String? error;
  final VoidCallback onVerify;

  const KycStep({
    super.key,
    required this.busy,
    required this.rejected,
    required this.error,
    required this.onVerify,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.verified_user_outlined,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 24),
        Text(
          'Vérification de votre identité',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        const Text(
          'Mode démonstration : le prestataire KYC est simulé. '
          'Aucun document n’est demandé et aucune vérification réelle '
          'n’est effectuée.',
        ),
        const SizedBox(height: 24),
        if (busy) ...[
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 16),
          const Text(
            'Vérification simulée en cours…',
            textAlign: TextAlign.center,
          ),
        ],
        if (rejected || error != null) ...[
          Text(
            rejected ? 'Vérification refusée. Vous pouvez réessayer.' : error!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          const SizedBox(height: 16),
        ],
        const SizedBox(height: 16),
        FilledButton(
          onPressed: busy ? null : onVerify,
          child: Text(
            rejected || error != null ? 'Réessayer' : 'Simuler la vérification',
          ),
        ),
      ],
    );
  }
}
