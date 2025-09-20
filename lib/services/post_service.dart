import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_model.dart';

class PostService {
  final _client = Supabase.instance.client;

  Future<List<PostModel>> fetchPosts({String filter = 'latest'}) async {
    final currentUser = _client.auth.currentUser;

    try {
      // First, try to fetch posts with likes using a simpler approach
      final postsData = await _client
          .from('posts')
          .select('*')
          .order('created_at', ascending: false);

      List<PostModel> posts = [];

      for (var postData in postsData) {
        // For each post, check if current user liked it
        bool isLiked = false;
        if (currentUser != null) {
          try {
            final likeData = await _client
                .from('likes')
                .select('id')
                .eq('user_id', currentUser.id)
                .eq('post_id', postData['id'])
                .maybeSingle();
            isLiked = likeData != null;
          } catch (e) {
            isLiked = false;
          }
        }

        // Add liked field to post data
        postData['liked'] = isLiked;
        posts.add(PostModel.fromJson(postData));
      }

      return posts;
    } catch (e) {
      return [];
    }
  }

  Future<void> createPost({
    required String content,
    String? mediaUrl,
    bool anonymous = false,
  }) async {
    final user = _client.auth.currentUser!;

    // Get user name from metadata or fallback to email prefix
    String authorName =
        user.userMetadata?['name'] ??
        user.email?.split('@').first ??
        'Anonymous';

    try {
      await _client.from('posts').insert({
        'author_id': user.id,
        'author_name': authorName,
        'content': content,
        'media_url': mediaUrl,
        'is_anonymous': anonymous,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      rethrow;
    }
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
