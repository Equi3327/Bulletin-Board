import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  // UserRepository({required this.firebaseAuth});

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    addUserDetails(
      name: name,
      email: email,
    );
  }

  Future<void> addUserDetails(
      {required String name, required String email}) async {
    await db.collection('users').add({
      'name': name,
      'email': email,
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("password", password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
