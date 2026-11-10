import 'package:flutter/material.dart';

class InterestsStep extends StatelessWidget {
  static const options = ['Bois et menuiserie', 'Poterie et céramique', 'Textile et couture', 'Bijouterie', 'Décoration', 'Rénovation'];

  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final VoidCallback onNext;

  const InterestsStep({super.key, required this.selected, required this.onToggle, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Qu’est-ce qui vous intéresse ?', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        const Text('Choisissez au moins un centre d’intérêt artisanal.'),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final option in options) FilterChip(label: Text(option), selected: selected.contains(option), onSelected: (_) => onToggle(option)),
          ],
        ),
        const SizedBox(height: 24),
        FilledButton(onPressed: selected.isEmpty ? null : onNext, child: const Text('Continuer')),
      ],
    );
  }
}
