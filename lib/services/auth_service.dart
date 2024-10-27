import 'package:firebase_auth/firebase_auth.dart';
import 'user_profile_service.dart';

abstract class AuthService {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> signInWithApple();
  Future<UserCredential?> signInWithEmailPassword(String email, String password);
  Future<UserCredential?> signUpWithEmailPassword(String email, String password);
  Future<void> signOut();
}
