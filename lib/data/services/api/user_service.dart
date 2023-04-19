import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/models/user.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  final String baseUrl = 'http://localhost:5000/users';
  final http.Client _client = http.Client();


  Future<User> getUser(String userId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.get(Uri.parse('$baseUrl/$userId'));
    final json = jsonDecode(response.body);
    return User.fromJson(json);
  }


  Future<void> updateUser(User user) async {
    // ability to select images from file system and upload them
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.patch(
      Uri.parse('$baseUrl/${user.userId}'),
      body: jsonEncode({'bio': user.bio, 'avatar_url': user.avatarUrl}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> followUser(String userId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.post(Uri.parse('$baseUrl/$userId/follow'));
    if (response.statusCode != 200) {
      throw Exception('Failed to follow user');
    }
  }

  Future<void> unfollowUser(String userId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.post(Uri.parse('$baseUrl/$userId/unfollow'));
    if (response.statusCode != 200) {
      throw Exception('Failed to unfollow user');
    }
  }

  Future<List<Post>> getCreated(int cursor) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.get(
      Uri.parse('$baseUrl/created?cursor=$cursor'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return List<Post>.from(
        json['data'].map((postJson) => Post.fromJson(postJson)),
      );
    } else {
      throw Exception('Failed to get Feed');
    }
  }

  Future<List<Post>> getSaved(int cursor) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.get(
      Uri.parse('$baseUrl/bookmarks?cursor=$cursor'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return List<Post>.from(
        json['data'].map((postJson) => Post.fromJson(postJson)),
      );
    } else {
      throw Exception('Failed to get Feed');
    }
  }
}
