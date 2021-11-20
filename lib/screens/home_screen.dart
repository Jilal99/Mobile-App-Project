import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app_group_project/services/firebase_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME SCREEN', style: TextStyle(fontSize: 18)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseService().userLogout(context);
            },
            icon: const Icon(
              FontAwesomeIcons.signOutAlt,
            ),
            tooltip: 'LOGOUT',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("THIS IS THE HOME SCREEN"),
          ],
        ),
      ),
    );
  }
}
