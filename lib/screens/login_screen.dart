import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app_group_project/components/snackbar.dart';
import 'package:mobile_app_group_project/constants/constants.dart';
import 'package:mobile_app_group_project/screens/landing_screen.dart';
import 'package:mobile_app_group_project/services/firebase_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isloading = false;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey[200],
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign In",
                  style: TextStyle(
                      fontSize: 50,
                      color: kAppColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 80),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Email";
                    }
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Email',
                    prefixIcon: const Icon(
                      FontAwesomeIcons.mailBulk,
                      color: kAppColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Password";
                    }
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                    prefixIcon: const Icon(
                      FontAwesomeIcons.userLock,
                      color: kAppColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        try {
                          await _firebaseService.loginEmailAndPassword(
                              email, password);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (con) => LandingScreen()));
                        } catch (e) {
                          snackbar(context, e.toString(), 3);
                        }
                      }
                    },
                    child: const Text("Sign In"),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?  "),
                    GestureDetector(
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: kAppColor,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
