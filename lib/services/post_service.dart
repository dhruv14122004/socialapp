import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_model.dart';

class PostService {
  final _client = Supabase.instance.client;

  Future<List<PostModel>> fetchPosts({String filter = 'latest'}) async {
    final currentUser = _client.auth.currentUser;

    // Fetch posts with likes information
    final query = _client
        .from('posts')
        .select('''
          *,
          likes(user_id)
        ''')
        .order('created_at', ascending: false);

    final data = await query;

    return (data as List<dynamic>).map((postData) {
      final post = postData as Map<String, dynamic>;
      final likes = post['likes'] as List<dynamic>? ?? [];

      // Check if current user liked this post
      final isLiked =
          currentUser != null &&
          likes.any((like) => like['user_id'] == currentUser.id);

      // Remove likes from post data and add liked field
      post.remove('likes');
      post['liked'] = isLiked;

      return PostModel.fromJson(post);
    }).toList();
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

  Future<void> toggleLike({required String postId}) async {
    final user = _client.auth.currentUser!;

    // Check if already liked
    final existingLike = await _client
        .from('likes')
        .select()
        .eq('user_id', user.id)
        .eq('post_id', postId)
        .maybeSingle();

    if (existingLike != null) {
      // Unlike
      await _client
          .from('likes')
          .delete()
          .eq('user_id', user.id)
          .eq('post_id', postId);
    } else {
      // Like
      await _client.from('likes').insert({
        'user_id': user.id,
        'post_id': postId,
      });
    }
  }
}
