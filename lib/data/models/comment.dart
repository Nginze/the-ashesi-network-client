class Comment {
  final String commentId;
  final String authorId;
  final String parentId;
  final String content;
  final String createdAt;

  Comment({
    required this.commentId,
    required this.authorId,
    required this.parentId,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      authorId: json['authorId'],
      parentId: json['parentId'],
      content: json['content'],
      createdAt: json['createdAt'],
    );
  }
}
