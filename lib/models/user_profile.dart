

class UserProfile {
  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final String? bio;
  final Map<String, int>? habits;

  UserProfile({
    required this.id,
    required this.name,
    this.email,
    this.photoUrl,
    this.bio,
    this.habits,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'].toString(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      photoUrl: json['picture'] as String?,
      bio: json['bio'] as String?,
      habits: Map<String, int>.from(json['habits'] ?? {}),
    );
  }
}
