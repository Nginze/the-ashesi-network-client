import 'package:intl/intl.dart';

class Comment {
  final String? commentId;
  final String postId;
  final String? parentId;
  final int replyCount;
  final String content;
  final DateTime createdAt;
  final Map<String, dynamic> author;

  Comment(
      {required this.commentId,
      required this.postId,
      required this.replyCount,
      required this.parentId,
      required this.content,
      required this.createdAt,
      required this.author});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['post_id'],
      commentId: json['comment_id'],
      replyCount: json['reply_count'],
      parentId: json['parent_id'],
      content: json['content'],
      createdAt:
          DateFormat('E, d MMM yyyy HH:mm:ss z').parse(json['created_at']),
      author: {
        'avatar_url': json['author']['avatar_url'],
        'username': json['author']['username'],
        'user_id': json['author']['user_id'],
      },
    );
  }
}
