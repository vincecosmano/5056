import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static FirebaseService? _instance;
  static FirebaseService get instance {
    if (_instance == null) {
      _instance = FirebaseService();
    }
    return _instance!;
  }

  FirebaseService() {
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  // Firestore Operations
  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection(collection).add(data);
  }

  Future<DocumentSnapshot> getDocument(String collection, String docId) async {
    return await FirebaseFirestore.instance.collection(collection).doc(docId).get();
  }

  Future<void> updateDocument(String collection, String docId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection(collection).doc(docId).update(data);
  }

  Future<void> deleteDocument(String collection, String docId) async {
    await FirebaseFirestore.instance.collection(collection).doc(docId).delete();
  }

  // Authentication Methods
  Future<User?> signIn(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<User?> signUp(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}