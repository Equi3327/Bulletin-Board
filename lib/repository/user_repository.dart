import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // UserRepository({required this.firebaseAuth});

  Future<void> signUp({required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Future<User?> getCurrentUser() async {
  //   return await firebaseAuth.currentUser;
  // }
  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Future<bool> isSignedIn() async {
  //   var currentUser = await firebaseAuth.currentUser;
  //   return currentUser != null;
  // }
}
