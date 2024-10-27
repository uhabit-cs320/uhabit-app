import 'package:UHabit/services/mock_user_profile_service.dart';
import 'package:UHabit/services/user_profile_service.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final UserProfileService _userService = MockUserProfileService(); // Switch to ApiUserProfileService when ready
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfile?>(
      future: _userService.getCurrentUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final userProfile = snapshot.data;
        if (userProfile == null) {
          return const Center(child: Text('No profile found'));
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: userProfile.photoUrl != null 
                    ? NetworkImage(userProfile.photoUrl!)
                    : null,
                ),
                const SizedBox(height: 16),
                Text(
                  userProfile.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  userProfile.email,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text(
                  userProfile.bio,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Habits',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView(
                    children: userProfile.habits.entries.map((entry) {
                      return ListTile(
                        title: Text(entry.key),
                        trailing: Text('${entry.value} days',
                          style: const TextStyle(fontSize: 15, color: Colors.lightGreen)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
