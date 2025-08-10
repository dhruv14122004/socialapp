import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_model.dart';

class PostService {
  final _client = Supabase.instance.client;

  Future<List<PostModel>> fetchPosts({String filter = 'latest'}) async {
    final query = _client
        .from('posts')
        .select()
        .order('created_at', ascending: false);
    final data = await query;
    return (data as List<dynamic>)
        .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> createPost({
    required String content,
    String? mediaUrl,
    bool anonymous = false,
  }) async {
    final user = _client.auth.currentUser!;
    await _client.from('posts').insert({
      'author_id': user.id,
      'author_name': user.userMetadata?['name'],
      'content': content,
      'media_url': mediaUrl,
      'is_anonymous': anonymous,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> vote(String postId, int delta) async {
    await _client.rpc(
      'vote_post',
      params: {'p_post_id': postId, 'p_delta': delta},
    );
  }
}
