import 'package:esme26/adress.dart';
import 'package:esme26/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: 'Onboarding'),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key, required this.title});

  final String title;
  User? user;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: 
        
        widget.user != null ? Text('User enrolled: ${widget.user!.firstName} ${widget.user!.lastName}') : ListView(
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

                widget.user = User(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  adress: adress,
                  birthDateInMillisFromEpoch: DateTime.parse(birthDateController.text).microsecondsSinceEpoch, // Replace with actual value from TextField
                );

                setState(() {});
              },
              child: const Text('Enroll'),
            ),
          ],
        ),
      ),
    );
  }
}
