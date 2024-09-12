import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  String email;
  String firstName;
  String lastName;
  String phone;
  final List<String> roles;
  final String location;
  String imageUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.roles,
    required this.location,
    required this.imageUrl,
  });

  // Factory method to create a UserModel from Firestore data
  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      phone: data['phone'] ?? '',
      location: data['location'] ?? '',
      roles: List<String>.from(data['roles'] ?? []),
      imageUrl: data['imageUrl'],
    );
  }

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'roles': roles,
      'location': location,
      'imageUrl': imageUrl,
    };
  }
}
