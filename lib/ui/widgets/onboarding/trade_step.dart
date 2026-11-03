import 'package:flutter/material.dart';

class TradeStep extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;
  final VoidCallback onNext;

  const TradeStep({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.onNext,
  });

  @override
  State<TradeStep> createState() => _TradeStepState();
}

class _TradeStepState extends State<TradeStep> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Quel est votre métier ?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          TextFormField(
            initialValue: widget.initialValue,
            decoration: const InputDecoration(
              labelText: 'Métier',
              hintText: 'Ex. : menuisier, potier, électricien…',
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.sentences,
            onChanged: widget.onChanged,
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Indiquez votre métier.'
                : null,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) widget.onNext();
            },
            child: const Text('Continuer'),
          ),
        ],
      ),
    );
  }
}
