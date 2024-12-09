// friend.dart
import 'package:UHabit/models/user_profile.dart';

enum FriendStatus {
  friend,
  restricted,
  removed;

  static FriendStatus fromString(String status) {
    return FriendStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == status.toLowerCase(),
      orElse: () => FriendStatus.friend,
    );
  }
}

class Friend {
  final int id;
  final int userId;
  final int friendId;
  final FriendStatus status;
  final DateTime createdDate;
  final DateTime updatedDate;
  UserProfile? friendProfile;

  Friend({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.status,
    required this.createdDate,
    required this.updatedDate,
    this.friendProfile,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      userId: json['userId'],
      friendId: json['friendId'],
      status: FriendStatus.fromString(json['status']),
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
      friendProfile: json['friendProfile'] != null 
          ? UserProfile.fromJson(json['friendProfile'])
          : null,
    );
  }
}