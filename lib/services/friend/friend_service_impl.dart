// friend_service.dart
import 'package:UHabit/models/friend.dart';
import 'package:UHabit/models/user_profile.dart';
import 'package:UHabit/services/api_utils.dart';
import 'package:UHabit/services/friend/friend_service.dart';
import 'package:UHabit/models/friend_request.dart';
import 'package:UHabit/services/profile/profile_service.dart';

class FriendServiceImpl implements FriendService {
  @override
  Future<List<Friend>> getFriends() async {
    final response = await ApiUtils.get<List<Friend>>(
      '/api/v1/friends',
      (json) => (json as List)
          .map((item) => Friend.fromJson(item))
          .toList(),
    );
    
    if (response != null) {
      final userService = ProfileService();
      await Future.wait(
        response.map((friend) async {
          friend.friendProfile = await userService.getPublicProfile(friend.friendId);
        })
      );
    }
    
    return response ?? [];
  }

  @override
  Future<void> removeFriend(String friendId) async {
    await ApiUtils.delete('/api/v1/friends/$friendId');
  }

  @override
  Future<bool> isFriend(String friendId) async {
    final response = await ApiUtils.get<bool>(
      '/api/v1/friends/isFriend/$friendId',
      (json) => json as bool,
    );
    return response ?? false;
  }

  @override
  Future<List<UserProfile>> getSuggestedFriends() async {
    final response = await ApiUtils.get<List<UserProfile>>(
      '/api/v1/friends/suggested',
      (json) => (json as List)
          .map((item) => UserProfile.fromJson(item))
          .toList(),
    );

    print('Suggested friends: ${response}');
    return response ?? [];
  }

  @override
  Future<List<UserProfile>> searchFriends(String query) async {
    final response = await ApiUtils.get<List<UserProfile>>(
      '/api/v1/friends/search?query=$query',
      (json) => (json as List)
          .map((item) => UserProfile.fromJson(item))
          .toList(),
    );
    return response ?? [];
  }

  @override
  Future<List<FriendRequest>> getIncomingFriendRequests() async {
    final response = await ApiUtils.get<List<FriendRequest>>(
      '/api/v1/friend-requests/incoming',
      (json) => (json as List)
          .map((item) => FriendRequest.fromJson(item))
          .toList(),
    );
    
    if (response != null) {
      final userService = ProfileService();
      // Fetch public profiles for each sender
      await Future.wait(
        response.map((request) async {
          request.senderProfile = await userService.getPublicProfile(request.senderId);

          print('Sender profile: ${request.senderProfile}');
        })
      );
    }
    
    return response ?? [];
  }

  @override
  Future<List<FriendRequest>> getOutgoingFriendRequests() async {
    final response = await ApiUtils.get<List<FriendRequest>>(
      '/api/v1/friend-requests/outgoing',
      (json) => (json as List)
          .map((item) => FriendRequest.fromJson(item))
          .toList(),
    );


    if (response != null) {
      final userService = ProfileService();
      await Future.wait(
        response.map((request) async {
          request.receiverProfile = await userService.getPublicProfile(request.receiverId);
        })
      );
    }
    return response ?? [];
  }

  @override
  Future<void> sendFriendRequest(String targetId) async {
    await ApiUtils.post(
      '/api/v1/friend-requests/$targetId',
      {},
      (json) => null,
    );
  }

  @override
  Future<void> acceptFriendRequest(String senderId) async {
    await ApiUtils.post(
      '/api/v1/friend-requests/accept/$senderId',
      {},
      (json) => null,
    );
  }

  @override
  Future<void> rejectFriendRequest(String senderId) async {
    await ApiUtils.post(
      '/api/v1/friend-requests/reject/$senderId',
      {},
      (json) => null,
    );
  }

  @override
  Future<void> cancelFriendRequest(String targetId) async {
    await ApiUtils.post(
      '/api/v1/friend-requests/cancel/$targetId',
      {},
      (json) => null,
    );
  }
}