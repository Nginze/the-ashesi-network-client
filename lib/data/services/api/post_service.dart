import 'dart:convert';
import 'package:frontend/data/models/comment.dart';
import 'package:frontend/data/models/post.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

class PostService {
  final String baseUrl = 'http://localhost:5000/posts';
  final http.Client _client = http.Client();

  Future<Post> getPost(String postId) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.get(Uri.parse('$baseUrl/$postId'));
    final json = jsonDecode(response.body);
    return Post.fromJson(json);
  }

  Future<void> createPost(Post post) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await _client.post(
      Uri.parse(baseUrl),
      body: jsonEncode({
        'post_id': post.postId,
        'title': post.title,
        'content': post.content,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create post');
    }
  }

  Future<List<Post>> getFeed(int cursor, String sort) async {
    (_client as BrowserClient).withCredentials = true;
    final response = await http.get(
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
}
