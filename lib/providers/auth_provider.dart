import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

// Import your UserModel class
import '../models/user_model.dart';

// Import the Firebase instances from firebase_provider.dart
import 'firebase_provider.dart';

class AuthProvider extends ChangeNotifier {
  // Use the Firebase instances from FirebaseProvider
  final FirebaseAuth _firebaseAuth = firebaseAuth;
  final FirebaseFirestore _firestore = firestore;
  final FirebaseStorage _firebaseStorage = firebaseStorage;

  UserModel? _userModel;

  AuthProvider() {
    // Initialize the provider by listening to auth state changes
    _firebaseAuth.authStateChanges().listen((User? user) async {
      if (user != null) {
        await _fetchUserDetails(user.uid);
      } else {
        _userModel = null;
      }
      notifyListeners(); // Notify listeners when user changes
    });
  }

  // Getter for the current user model
  UserModel? get user => _userModel;

  // Getter to check if user is signed in
  bool get isSignedIn => _userModel != null;

  // Method to fetch user details from Firestore
  Future<void> _fetchUserDetails(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        _userModel = UserModel.fromFirestore(doc);
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  // Method to sign in with email and password
  Future<void> signInWithEmail(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await _fetchUserDetails(
          credential.user!.uid); // Fetch user details after sign-in
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // Method to sign out the user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      _userModel = null;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  // Method to register a new user
  Future<void> registerWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createUserAccount({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required List<String> roles,
    required String password,
    required String district,
    File? imageFile, // Make imageFile optional
  }) async {
    try {
      // Create user with email and password
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user id from the created credential
      final uid = credential.user?.uid;

      // Check if user creation was successful
      if (uid != null) {
        String? imageUrl;

        // Check if an image file is provided
        if (imageFile != null) {
          // Extract the file extension from the image file
          final String fileExtension = path.extension(imageFile.path);
          final String imagePath =
              'user_images/$uid/profile_image$fileExtension'; // Define path for image

          // Upload image to Firebase Storage
          final TaskSnapshot uploadTask =
              await _firebaseStorage.ref().child(imagePath).putFile(imageFile);

          // Get the image URL after successful upload
          imageUrl = await uploadTask.ref.getDownloadURL();
        }

        // Store additional user data in Firestore, conditionally including imageUrl
        await _firestore.collection('users').doc(uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'phone': phone,
          'roles': roles,
          'location': district,
          if (imageUrl != null)
            'imageUrl': imageUrl, // Conditionally store image URL
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Fetch the user details to update the user model
        await _fetchUserDetails(uid);
      }

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      } else {
        throw e.message ?? 'Failed to create account';
      }
    } catch (e) {
      throw 'An error occurred while creating the account: $e';
    }
  }

  Future<void> updateUserImage(File imageFile) async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw Exception('No user is currently signed in.');
      }

      // Extract the file extension from the image file
      final String fileExtension = path.extension(imageFile.path);
      final String imagePath =
          'user_images/${user.uid}/profile_image$fileExtension'; // Define path for image

      // Upload image to Firebase Storage
      final TaskSnapshot uploadTask =
          await _firebaseStorage.ref().child(imagePath).putFile(imageFile);
      final imageUrl = await uploadTask.ref.getDownloadURL();

      // Update user's photo URL in Firebase Authentication
      await user.updatePhotoURL(imageUrl);

      // Update user's photo URL in Firestore
      print("Image URL: $imageUrl");
      await _firestore.collection('users').doc(user.uid).update({
        'imageUrl': imageUrl,
      });

      // Reload user to apply changes
      await user.reload();
      _userModel?.imageUrl = imageUrl;
      notifyListeners();
    } catch (e) {
      print('Failed to update profile image: $e');
      throw e;
    }
  }

// update user first name and last name
  Future<void> updateUserProfile({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw Exception('No user is currently signed in.');
      }

      // Update user's first name and last name in Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
      });

      //go through firestore offers section and and find where the uid is equal to the user.uid and update the name
      final offers = await _firestore
          .collection('offers')
          .where('uid', isEqualTo: user.uid)
          .get();
      for (final offer in offers.docs) {
        await offer.reference.update({
          'name': '$firstName',
        });
      }

      // Reload user to apply changes
      await user.reload();
      _userModel?.firstName = firstName;
      _userModel?.lastName = lastName;
      _userModel?.phone = phone;
      _userModel?.email = email;
      notifyListeners();
    } catch (e) {
      print('Failed to update profile: $e');
      throw e;
    }
  }

// Method to send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e; // Handle errors appropriately in your UI
    }
  }
}
