import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String bio;
  final Map<String, int> habits;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.bio,
    required this.habits,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photo_url'],
      bio: json['bio'],
      habits: Map<String, int>.from(json['habits'] ?? {}),
    );
  }
}

abstract class UserProfileService {
  Future<UserProfile?> getCurrentUserProfile();
  Future<void> updateUserProfile(UserProfile profile);
}
