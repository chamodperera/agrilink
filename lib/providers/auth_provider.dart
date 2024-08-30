import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;

  AuthProvider() {
    // Initialize the provider by listening to auth state changes
    _firebaseAuth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners(); // Notify listeners when user changes
    });
  }

  // Getter for the current user
  User? get user => _user;

  // Getter to check if user is signed in
  bool get isSignedIn => _user != null;

  // Method to sign in with email and password
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      // Handle sign-in errors here
      print(e.toString());
    }
  }

  // Method to sign out the user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      // Handle sign-out errors here
      print(e.toString());
    }
  }

  // Method to register a new user
  Future<void> registerWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      // Handle registration errors here
      print(e.toString());
    }
  }
}
