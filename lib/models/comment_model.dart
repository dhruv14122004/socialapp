class CommentModel {
  final String id;
  final String postId;
  final String authorId;
  final String? authorName;
  final String content;
  final bool isAnonymous;
  final DateTime createdAt;

  const CommentModel({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.content,
    required this.createdAt,
    this.authorName,
    this.isAnonymous = false,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json['id'] as String,
    postId: json['post_id'] as String,
    authorId: json['author_id'] as String,
    authorName: json['author_name'] as String?,
    content: json['content'] as String,
    isAnonymous: (json['is_anonymous'] as bool?) ?? false,
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'post_id': postId,
    'author_id': authorId,
    'author_name': authorName,
    'content': content,
    'is_anonymous': isAnonymous,
    'created_at': createdAt.toIso8601String(),
  };
}
