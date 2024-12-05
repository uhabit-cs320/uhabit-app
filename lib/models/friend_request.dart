import 'package:UHabit/models/user_profile.dart';

enum FriendRequestStatus {
  pending,
  accepted,
  rejected,
  rescinded;

  static FriendRequestStatus fromIndex(int index) {
    return FriendRequestStatus.values[index];
  }

  static FriendRequestStatus fromString(String status) {
    return FriendRequestStatus.values.firstWhere((e) => e.name == status.toLowerCase());
  }
}

class FriendRequest {
  final int id;
  final int senderId;
  final int receiverId;
  final DateTime date;
  final FriendRequestStatus status;
  UserProfile? senderProfile;
  UserProfile? receiverProfile;

  FriendRequest({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.date,
    required this.status,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    print('Friend request: ${json}');
    return FriendRequest(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      date: DateTime.parse(json['date']),
      status: FriendRequestStatus.fromString(json['status']),
    );
  }
} 