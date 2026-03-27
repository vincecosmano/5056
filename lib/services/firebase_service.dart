import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static FirebaseService? _instance;
  static FirebaseService get instance {
    _instance ??= FirebaseService();
    return _instance!;
  }

  // Authentication Methods
  Future<User?> signIn(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<User?> signUp(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}