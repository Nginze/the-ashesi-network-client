import 'dart:convert';
import 'package:frontend/data/models/comment.dart';
import 'package:frontend/data/models/post.dart';
import 'package:http/http.dart' as http;

class PostService {
  final String baseUrl = 'http://localhost:5000/posts';

  Future<Post> getPost(String postId) async {
    final response = await http.get(Uri.parse('$baseUrl/$postId'));
    final json = jsonDecode(response.body);
    return Post.fromJson(json);
  }

  Future<void> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode({
        'post_id': post.postId,
        'author_id': post.authorId,
        'title': post.title,
        'content': post.content,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create post');
    }
  }

  // Future<void> updatePost(Post post) async {
  //   final response = await http.patch(
  //     Uri.parse('$baseUrl/${post.postId}'),
  //     body: jsonEncode({
  //       'title': post.title,
  //       'body': post.body,
  //     }),
  //   );
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to update post');
  //   }
  // }

  Future<void> deletePost(String postId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$postId'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete post');
    }
  }

  Future<List<Comment>> getComments(String postId, int cursor) async {
    final response = await http
        .get(Uri.parse(('$baseUrl/$postId/comment/all?cursor=$cursor')));
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return List<Comment>.from(
        json.map((commentJson) => Comment.fromJson(commentJson)),
      );
    }else{
      throw Exception('Failed to get Comments');
    }
  }
}
