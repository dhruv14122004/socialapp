import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/message_model.dart';

class ChatService {
  final _client = Supabase.instance.client;

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
}
