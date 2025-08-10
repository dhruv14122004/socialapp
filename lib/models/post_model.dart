class PostModel {
  final String id;
  final String authorId;
  final String? authorName;
  final String content;
  final String? mediaUrl;
  final bool isAnonymous;
  final int upvotes;
  final int downvotes;
  final String category; // latest|top|announcements (for filter)
  final DateTime createdAt;

  const PostModel({
    required this.id,
    required this.authorId,
    required this.content,
    required this.createdAt,
    this.authorName,
    this.mediaUrl,
    this.isAnonymous = false,
    this.upvotes = 0,
    this.downvotes = 0,
    this.category = 'latest',
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'] as String,
    authorId: json['author_id'] as String,
    authorName: json['author_name'] as String?,
    content: json['content'] as String,
    mediaUrl: json['media_url'] as String?,
    isAnonymous: (json['is_anonymous'] as bool?) ?? false,
    upvotes: (json['upvotes'] as int?) ?? 0,
    downvotes: (json['downvotes'] as int?) ?? 0,
    category: (json['category'] as String?) ?? 'latest',
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'author_id': authorId,
    'author_name': authorName,
    'content': content,
    'media_url': mediaUrl,
    'is_anonymous': isAnonymous,
    'upvotes': upvotes,
    'downvotes': downvotes,
    'category': category,
    'created_at': createdAt.toIso8601String(),
  };
}
