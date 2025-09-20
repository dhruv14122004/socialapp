import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class ChatService {
  final _client = Supabase.instance.client;

  // Fetch all users for chat list
  Future<List<AppUser>> fetchUsers() async {
    final currentUserId = _client.auth.currentUser!.id;

    final response = await _client
        .from('users')
        .select()
        .neq('id', currentUserId); // Exclude current user

    return (response as List<dynamic>)
        .map((data) => AppUser.fromJson(data as Map<String, dynamic>))
        .toList();
  }

  // Get latest message between current user and another user
  Future<MessageModel?> getLatestMessage(String otherUserId) async {
    final myId = _client.auth.currentUser!.id;

    final response = await _client
        .from('messages')
        .select()
        .or('from_id.eq.$myId,to_id.eq.$myId')
        .or('from_id.eq.$otherUserId,to_id.eq.$otherUserId')
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();

    if (response == null) return null;
    return MessageModel.fromJson(response);
  }

  Stream<List<MessageModel>> messagesStream(String otherUserId) {
    final myId = _client.auth.currentUser!.id;
    return _client
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map(
          (rows) => rows
              .where(
                (m) =>
                    (m['from_id'] == myId && m['to_id'] == otherUserId) ||
                    (m['from_id'] == otherUserId && m['to_id'] == myId),
              )
              .map((e) => MessageModel.fromJson(e))
              .toList(),
        );
  }

  Future<void> send({
    required String toId,
    String? content,
    String? mediaUrl,
  }) async {
    final myId = _client.auth.currentUser!.id;
    await _client.from('messages').insert({
      'from_id': myId,
      'to_id': toId,
      'content': content,
      'media_url': mediaUrl,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  // Mark messages as read
  Future<void> markAsRead(String fromUserId) async {
    final myId = _client.auth.currentUser!.id;
    await _client
        .from('messages')
        .update({'is_read': true})
        .eq('from_id', fromUserId)
        .eq('to_id', myId);
  }
}
