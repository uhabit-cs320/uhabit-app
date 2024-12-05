import 'package:UHabit/models/user_profile.dart';
abstract class UserProfileService {
  Future<UserProfile?> getCurrentUserProfile();
  Future<void> updateUserProfile(UserProfile profile);
}
