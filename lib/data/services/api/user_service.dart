import 'package:frontend/data/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {

  final String baseUrl = 'http://localhost:5000/users';

  Future<User> getUser(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/$userId'));
    final json = jsonDecode(response.body);
    return User.fromJson(json);
  }

  Future<void> updateUser(User user) async {
    // ability to select images from file system and upload them
    final response = await http.patch(
      Uri.parse('$baseUrl/${user.userId}'),
      body: jsonEncode({
        'bio': user.bio,
        'avatar_url': user.avatarUrl
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> followUser(String userId) async {
    final response = await http.post(Uri.parse('$baseUrl/$userId/follow'));
    if (response.statusCode != 200) {
      throw Exception('Failed to follow user');
    }
  }

  Future<void> unfollowUser(String userId) async {
    final response = await http.post(Uri.parse('$baseUrl/$userId/unfollow'));
    if (response.statusCode != 200) {
      throw Exception('Failed to unfollow user');
    }
  }
}
