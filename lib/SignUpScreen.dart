// ignore_for_file: use_super_parameters

import 'package:UHabit/EmailSignUpScreen.dart';
import 'package:UHabit/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatelessWidget {
  final AuthService authService;

  SignUpScreen({Key? key, required this.authService}) : super(key: key);

  Future<void> _handleGoogleSignIn() async {
    await authService.signInWithGoogle();
  }

  Future<void> _handleAppleSignIn() async {
    await authService.signInWithApple();
  }

  Future<void> _handleEmailPasswordSignUp(BuildContext context) async {
    // Navigate to a new screen for email/password sign up
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmailSignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              ElevatedButton.icon(
                onPressed: _handleGoogleSignIn,
                icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                label: const Text(
                  'Continue with Google',
                  style: TextStyle(color: Colors.black87),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              if (Theme.of(context).platform == TargetPlatform.iOS)
                ElevatedButton.icon(
                  onPressed: _handleAppleSignIn,
                  icon: const FaIcon(FontAwesomeIcons.apple),
                  label: const Text('Continue with Apple'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              
              const SizedBox(height: 32),
              
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('or', style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              
              const SizedBox(height: 32),
              
              TextButton(
                onPressed: () => _handleEmailPasswordSignUp(context),
                child: const Text(
                  'Sign up with email and password',
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
