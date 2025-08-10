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
  final bool liked; // For favorites functionality

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
    this.liked = false,
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
    liked: (json['liked'] as bool?) ?? false,
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
    'liked': liked,
    'created_at': createdAt.toIso8601String(),
  };

  PostModel copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? content,
    String? mediaUrl,
    bool? isAnonymous,
    int? upvotes,
    int? downvotes,
    String? category,
    bool? liked,
    DateTime? createdAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      category: category ?? this.category,
      liked: liked ?? this.liked,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
