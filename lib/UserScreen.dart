import 'package:UHabit/services/health_service.dart';
import 'package:UHabit/services/user/user_profile_service_mock.dart';
import 'package:UHabit/services/user/user_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:UHabit/models/user_profile.dart';
class UserScreen extends StatelessWidget {
  final UserProfileService _userService = UserProfileServiceMock();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfile?>(
      future: _userService.getCurrentUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final userProfile = snapshot.data;
        if (userProfile == null) {
          return const Center(child: Text('No profile found'));
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {}, // Add settings navigation
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Profile Section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: userProfile.photoUrl != null 
                          ? NetworkImage(userProfile.photoUrl!)
                          : null,
                        child: userProfile.photoUrl == null 
                          ? const Icon(Icons.person, size: 50, color: Colors.grey)
                          : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userProfile.name ?? 'Anonymous',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      if (userProfile.email != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          userProfile.email!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                      if (userProfile.bio != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          userProfile.bio!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                ),

                // Habits Section
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Text(
                        'Habits',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Text(
                        '${userProfile.habits?.length ?? 0} total',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  itemCount: userProfile.habits?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final habit = userProfile.habits!.entries.elementAt(index);
                    return Card(
                      elevation: 0,
                      color: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          habit.key,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${habit.value} days',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
