class MessageModel {
  final String id;
  final String fromId;
  final String toId;
  final String? content;
  final String? mediaUrl;
  final DateTime createdAt;
  final bool isRead;

  const MessageModel({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.createdAt,
    this.content,
    this.mediaUrl,
    this.isRead = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['id'] as String,
    fromId: json['from_id'] as String,
    toId: json['to_id'] as String,
    content: json['content'] as String?,
    mediaUrl: json['media_url'] as String?,
    isRead: (json['is_read'] as bool?) ?? false,
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'from_id': fromId,
    'to_id': toId,
    'content': content,
    'media_url': mediaUrl,
    'is_read': isRead,
    'created_at': createdAt.toIso8601String(),
  };
}
