import 'package:UHabit/models/user_profile.dart';
import 'package:UHabit/services/api_utils.dart';

class ProfileService {
  Future<UserProfile?> getPublicProfile(int userId) async {
    return await ApiUtils.get<UserProfile>(
      '/api/v1/user/public-profile/$userId',
      (json) => UserProfile.fromJson(json),
    );
  }
} 