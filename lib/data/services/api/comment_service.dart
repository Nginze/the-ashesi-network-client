import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/data/models/comment.dart';

class CommentService {
  final String baseUrl = 'http://localhost:5000/comments';

  Future<Comment> getComment(String commentId) async {
    final response = await http.get(Uri.parse('$baseUrl/$commentId'));
    final json = jsonDecode(response.body);
    return Comment.fromJson(json);
  }

  Future<void> createComment(Comment comment) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode({
        'author_id': comment.authorId,
        'parent_id': comment.parentId,
        'content': comment.content
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create comment');
    }
  }

  Future<void> deleteComment(String commentId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$commentId'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete comment');
    }
  }

Future<List<Comment>> getReplies(String parentId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$parentId/replies/all'),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return List<Comment>.from(
        json.map((commentJson) => Comment.fromJson(commentJson)),
      );
    } else {
      throw Exception('Failed to get replies');
    }
  }

}
