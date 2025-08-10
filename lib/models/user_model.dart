class AppUser {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final DateTime joinedAt;
  final bool isAdmin;
  final bool isOnline;

  const AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.joinedAt,
    this.avatarUrl,
    this.isAdmin = false,
    this.isOnline = false,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    id: json['id'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    avatarUrl: json['avatar_url'] as String?,
    isAdmin: (json['is_admin'] as bool?) ?? false,
    isOnline: (json['is_online'] as bool?) ?? false,
    joinedAt: DateTime.parse(json['joined_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'avatar_url': avatarUrl,
    'is_admin': isAdmin,
    'is_online': isOnline,
    'joined_at': joinedAt.toIso8601String(),
  };
}
