class Post {
  final String postId;
  final String authorId;
  final String title;
  final String content;
  final String mediaUrl;
  final DateTime createdAt;

  Post({
    required this.postId,
    required this.authorId,
    required this.title,
    required this.content,
    required this.mediaUrl,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['post_id'],
      authorId: json['author_id'],
      title: json['title'],
      content: json['content'],
      mediaUrl: json['media_url'],
      createdAt: json['created_at'],
    );
  }
}
