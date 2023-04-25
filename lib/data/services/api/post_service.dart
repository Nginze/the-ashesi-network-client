import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/comment.dart';
import 'package:frontend/data/models/post.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class PostService {
  static bool isprod = true;
  final String baseUrl = isprod
      ? 'https://flask-production-b88c.up.railway.app/posts'
      : 'http://localhost:5000/posts';
  final http.Client _client = http.Client();

  Future<Post> getPost(String postId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.get(Uri.parse('$baseUrl/$postId'));
    final json = jsonDecode(response.body);
    return Post.fromJson(json);
  }

  Future<Map> createPost(Map<String, dynamic> post) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.post(
      Uri.parse('$baseUrl/'),
      body: jsonEncode(post),
    );
    if (response.statusCode != 200) {
      Fluttertoast.showToast(
          msg: "Couldn't Create Post! Try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          webPosition: 'center',
          webBgColor: "#101110",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      throw Exception('Failed to create post');
    } else {
      Fluttertoast.showToast(
          msg: "Created Post!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          webPosition: 'center',
          webBgColor: "#101110",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      final json = jsonDecode(response.body);
      return json;
    }
  }

  Future<List<Post>> getFeed(int cursor, String sort) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.get(
      Uri.parse('$baseUrl/feed?cursor=$cursor&sort=$sort'),
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

  Future<void> deletePost(String postId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.delete(Uri.parse('$baseUrl/$postId'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete post');
    }
  }

  Future<List<Comment>> getComments(int cursor, String postId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client
        .get(Uri.parse(('$baseUrl/$postId/comment/all?cursor=$cursor')));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return List<Comment>.from(
        json['data'].map((commentJson) => Comment.fromJson(commentJson)),
      );
    } else {
      throw Exception('Failed to get Comments');
    }
  }

  void likePost(String postId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.post(Uri.parse('$baseUrl/$postId/like'));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Liked Post!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          webPosition: 'center',
          webBgColor: "#101110",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error Liking Post. Try again",
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

  void unLikePost(String postId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.delete(Uri.parse('$baseUrl/$postId/unlike'));
    if (response.statusCode == 204) {
      Fluttertoast.showToast(
          msg: "unliked Post!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          webPosition: 'center',
          webBgColor: "#101110",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error Liking Post. Try again",
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

  void savePost(String postId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.post(Uri.parse('$baseUrl/$postId/save'));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Saved Post!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          webPosition: 'center',
          webBgColor: "#101110",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error Saving Post. Try again",
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

  void unSavePost(String postId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.delete(Uri.parse('$baseUrl/$postId/unsave'));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "unsaved Post!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          webPosition: 'center',
          webBgColor: "#101110",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error unsaving post. Try again!",
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
}
