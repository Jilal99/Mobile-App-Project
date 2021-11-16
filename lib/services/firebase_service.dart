import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInAnon() async {
    return await _auth.signInAnonymously();
  }

  Stream<User?> userChangesStream() {
    return _auth.userChanges();
  }
}
