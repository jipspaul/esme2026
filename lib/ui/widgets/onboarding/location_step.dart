import 'package:flutter/material.dart';

class LocationStep extends StatefulWidget {
  final String city;
  final String postalCode;
  final String country;
  final ValueChanged<String> onCityChanged;
  final ValueChanged<String> onPostalCodeChanged;
  final ValueChanged<String> onCountryChanged;
  final VoidCallback onNext;

  const LocationStep({
    super.key,
    required this.city,
    required this.postalCode,
    required this.country,
    required this.onCityChanged,
    required this.onPostalCodeChanged,
    required this.onCountryChanged,
    required this.onNext,
  });

  @override
  State<LocationStep> createState() => _LocationStepState();
}

class _LocationStepState extends State<LocationStep> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Où êtes-vous situé ?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Renseignez votre localisation pour découvrir les artisans '
            'et projets près de chez vous.',
          ),
          const SizedBox(height: 24),
          TextFormField(
            initialValue: widget.city,
            decoration: const InputDecoration(labelText: 'Ville'),
            textCapitalization: TextCapitalization.words,
            onChanged: widget.onCityChanged,
            validator: _requiredLocation,
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: widget.postalCode,
            decoration: const InputDecoration(labelText: 'Code postal'),
            onChanged: widget.onPostalCodeChanged,
            validator: _requiredLocation,
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: widget.country,
            decoration: const InputDecoration(labelText: 'Pays'),
            textCapitalization: TextCapitalization.words,
            onChanged: widget.onCountryChanged,
            validator: _requiredLocation,
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

  String? _requiredLocation(String? value) =>
      value == null || value.trim().isEmpty
      ? 'Ce champ est obligatoire.'
      : null;
}
