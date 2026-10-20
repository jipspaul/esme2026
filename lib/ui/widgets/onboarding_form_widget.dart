import 'package:esme26/data/models/adress.dart';
import 'package:esme26/data/models/user.dart';
import 'package:flutter/material.dart';

class OnboardingFormWidget extends StatefulWidget {
  final Function(User) userCallback;
  const OnboardingFormWidget({super.key, required this.userCallback});

  @override
  State<OnboardingFormWidget> createState() => _OnboardingFormWidgetState();
}

class _OnboardingFormWidgetState extends State<OnboardingFormWidget> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
              textCapitalization: TextCapitalization.words,
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
              textCapitalization: TextCapitalization.words,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: birthDateController,
              decoration: InputDecoration(
                labelText: 'Birth Date',
                hintText: 'YYYY-MM-DD',
              ),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: streetController,
              decoration: InputDecoration(labelText: 'Street'),
              keyboardType: TextInputType.streetAddress,
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
              textCapitalization: TextCapitalization.words,
            ),
            TextField(
              controller: postalCodeController,
              decoration: InputDecoration(labelText: 'Postal Code'),
            ),
            TextField(
              controller: countryController,
              decoration: InputDecoration(labelText: 'Country'),
              textCapitalization: TextCapitalization.words,
            ),
            ElevatedButton(
              onPressed: () {
                Adress adress = Adress(
                  street: streetController.text,
                  city: cityController.text,
                  postalCode: postalCodeController.text,
                  country: countryController.text,
                );

                widget.userCallback(User(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  adress: adress,
                  birthDateInMillisFromEpoch: DateTime.parse(birthDateController.text).microsecondsSinceEpoch, // Replace with actual value from TextField
                ));

              },
              child: const Text('Enroll'),
            ),
          ],
        );
  }
}