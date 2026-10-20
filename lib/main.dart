import 'package:esme26/data/models/adress.dart';
import 'package:esme26/ui/widgets/onboarding_form_widget.dart';
import 'package:esme26/data/models/user.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: widget.user != null ? Text('User enrolled: ${widget.user!.firstName} ${widget.user!.lastName}') 
        : OnboardingFormWidget(userCallback: (user) {
            setState(() {
              widget.user = user;
            });
          }),
      ),
    );
  }
}
