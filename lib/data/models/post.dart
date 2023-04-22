import 'package:intl/intl.dart';
// class Post {
//   final String postId;
//   final String authorId;
//   final String title;
//   final String content;
//   final String mediaUrl;
//   final DateTime createdAt;

//   Post({
//     required this.postId,
//     required this.authorId,
//     required this.title,
//     required this.content,
//     required this.mediaUrl,
//     required this.createdAt,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       postId: json['post_id'],
//       authorId: json['author_id'],
//       title: json['title'],
//       content: json['content'],
//       mediaUrl: json['media_url'],
//       createdAt: json['created_at'],
//     );
//   }
// }

class Post {
  final String postId;
  final String? mediaUrl;
  final String? title;
  final String content;
  final int? likeCount;
  final int? commentCount;
  final bool? hasLiked;
  final bool? hasSaved;
  final DateTime createdAt;
  final Map<String, dynamic> author;

  Post(
      {required this.postId,
      required this.mediaUrl,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.author,
      required this.likeCount,
      required this.hasLiked,
      required this.hasSaved,
      required this.commentCount});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['post_id'],
      mediaUrl: json['media_url'],
      title: json['title'],
      content: json['content'],
      likeCount: json['likes_count'],
      commentCount: json['comments_count'],
      hasLiked: json['has_liked'],
      hasSaved: json['has_saved'],
      createdAt:
          DateFormat('E, d MMM yyyy HH:mm:ss z').parse(json['created_at']),
      author: {
        'avatar_url': json['author']['avatar_url'],
        'username': json['author']['username'],
        'id': json['author']['user_id'],
      },
    );
  }
}
