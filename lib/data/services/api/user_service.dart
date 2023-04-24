import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/data/models/post.dart';
import 'package:frontend/data/models/user.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static bool isprod = true;
  final String baseUrl = isprod
      ? 'https://flask-production-b88c.up.railway.app/users'
      : 'http://localhost:5000/users';
  final http.Client _client = http.Client();

  Future<User> getUser(String userId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.get(Uri.parse('$baseUrl/$userId'));
    final json = jsonDecode(response.body);
    return User.fromJson(json);
  }

  Future<void> updateUser(User user) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.patch(
      Uri.parse('$baseUrl/${user.userId}'),
      body: jsonEncode({
        'bio': user.bio,
        'major': user.major,
        'year_group': user.yearGroup,
        'favorite_food': user.favoriteFood,
        'favorite_movie': user.favoriteMovie,
        'residency': user.residency
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    } else {
      Fluttertoast.showToast(
          msg: "Updated Your Profile",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          webPosition: 'center',
          webBgColor: "#101110",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
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

  Future<List<dynamic>> getSuggested() async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.get(
      Uri.parse('$baseUrl/suggestions'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // print(json);
      return json;
    } else {
      throw Exception('Failed to get Suggestion');
    }
  }
}
