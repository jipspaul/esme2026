import 'package:flutter/material.dart';

class NameStep extends StatefulWidget {
  final String firstName;
  final String lastName;
  final ValueChanged<String> onFirstNameChanged;
  final ValueChanged<String> onLastNameChanged;
  final VoidCallback onNext;

  const NameStep({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
    required this.onNext,
  });

  @override
  State<NameStep> createState() => _NameStepState();
}

class _NameStepState extends State<NameStep> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Comment vous appelez-vous ?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          TextFormField(
            initialValue: widget.firstName,
            decoration: const InputDecoration(labelText: 'Prénom'),
            textCapitalization: TextCapitalization.words,
            autofillHints: const [AutofillHints.givenName],
            onChanged: widget.onFirstNameChanged,
            validator: _requiredName,
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: widget.lastName,
            decoration: const InputDecoration(labelText: 'Nom'),
            textCapitalization: TextCapitalization.words,
            autofillHints: const [AutofillHints.familyName],
            onChanged: widget.onLastNameChanged,
            validator: _requiredName,
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

  String? _requiredName(String? value) => value == null || value.trim().isEmpty
      ? 'Ce champ est obligatoire.'
      : null;
}
