import 'dart:convert';
import 'package:UHabit/models/user_profile.dart';
import 'package:http/http.dart' as http;
import 'user_profile_service.dart';

class UserProfileServiceImpl implements UserProfileService {
  final String baseUrl = 'https://api.uhabit.com'; // Replace with your actual API URL
  final String? authToken;

  UserProfileServiceImpl({this.authToken});

  @override
  Future<UserProfile?> getCurrentUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/profile'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return UserProfile.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  @override
  Future<void> updateUserProfile(UserProfile profile) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/user/profile'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': profile.name,
          'email': profile.email,
          'photo_url': profile.photoUrl,
          'bio': profile.bio,
          'habits': profile.habits,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      print('Error updating user profile: $e');
      rethrow;
    }
  }
}
