import 'package:flutter/material.dart';
import 'package:mobile_app_group_project/screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: LandingScreen(),
      routes: const {
        //TODO Add any future routes here
        //! Example '/login': (BuildContext context) => const LoginScreen(),
      },
    );
  }
}
