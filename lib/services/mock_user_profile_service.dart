import 'package:firebase_auth/firebase_auth.dart';
import 'user_profile_service.dart';

class MockUserProfileService implements UserProfileService {
  UserProfile? _currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserProfile?> getCurrentUserProfile() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;

    if (_currentUser == null || _currentUser!.id != firebaseUser.uid) {
      _currentUser = UserProfile(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? 'New User',
        email: firebaseUser.email ?? '',
        photoUrl: firebaseUser.photoURL,
        bio: 'Welcome to UHabit!',
        habits: {
          'Exercise': 0,
          'Reading': 0,
          'Meditation': 0,
        },
      );
    }
    return _currentUser;
  }

  @override
  Future<void> updateUserProfile(UserProfile profile) async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return;

    _currentUser = profile;
    
    // Optionally update Firebase user profile
    await firebaseUser.updateDisplayName(profile.name);
    if (profile.photoUrl != null) {
      await firebaseUser.updatePhotoURL(profile.photoUrl);
    }
  }
}
