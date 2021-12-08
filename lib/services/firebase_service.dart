import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_group_project/components/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static FirebaseFirestore db = FirebaseFirestore.instance;

  Future<UserCredential> signInAnon() async {
    return await auth.signInAnonymously();
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> userLogout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text('YES'),
              onPressed: () async {
                try {
                  await auth.signOut();
                  snackbar(context, 'User successfully logged out.', 5);
                  Navigator.of(context).pop();
                } catch (error) {
                  throw ErrorDescription(error.toString());
                }
              },
            ),
          ],
        );
      },
    );
  }

  Stream<User?> userChangesStream() {
    return auth.userChanges();
  }

  Future<UserCredential?> loginEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      }
    }
  }

  static Future<User?> registerEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
    return user;
  }

  static Future<void> register(
      BuildContext context,
      File? imageFile,
      String email,
      String password,
      String firstname,
      String lastname,
      String bio,
      String hometown,
      String year) async {
    try {
      User? user = await FirebaseService.registerEmailPassword(
          email: email, password: password);

      String fileName = imageFile!.path;
      String? downloadURL;
      try {
        await storage.ref('uploads/$fileName').putFile(imageFile);
        downloadURL = await firebase_storage.FirebaseStorage.instance
            .ref('uploads/$fileName')
            .getDownloadURL();
      } on firebase_storage.FirebaseException catch (e) {
        snackbar(context, e.toString(), 3);
      }
      db
          .collection("users")
          .doc(user!.uid)
          .set({
            "first_name": firstname,
            "last_name": lastname,
            "timestamp": DateTime.now(),
            "bio": bio,
            "hometown": hometown,
            "year": year,
            "picture_url": downloadURL
          })
          .then((value) => null)
          .onError((error, stackTrace) => null);
    } on FirebaseAuthException catch (e) {
      snackbar(context, e.toString(), 3);
    } catch (e) {
      snackbar(context, "Registration Error", 3);
    }
  }
}
