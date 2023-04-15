import 'package:intl/intl.dart';

class Comment {
  final String? commentId;
  final String? parentId;
  final String content;
  final DateTime createdAt;
  final Map<String, dynamic> author;

  Comment({
    required this.commentId,
    // required this.authorId,
    required this.parentId,
    required this.content,
    required this.createdAt,
    required this.author
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      // authorId: json['authorId'],
      parentId: json['parentId'],
      content: json['content'],
      createdAt: DateFormat('E, d MMM yyyy HH:mm:ss z').parse(json['created_at']),
      author: {
        'avatar_url': json['author']['avatar_url'],
        'username': json['author']['username'],
        'id': json['author']['id'],
      },
    );
  }
}
