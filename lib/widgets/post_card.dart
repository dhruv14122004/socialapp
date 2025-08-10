import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onTap;
  final VoidCallback? onShare;
  final VoidCallback? onComment;
  final VoidCallback? onUpvote;
  final VoidCallback? onDownvote;

  const PostCard({
    super.key,
    required this.post,
    this.onTap,
    this.onShare,
    this.onComment,
    this.onUpvote,
    this.onDownvote,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 20, child: Icon(Icons.person)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.isAnonymous
                              ? 'Anonymous'
                              : (post.authorName ?? 'User'),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          _timeLabel(post.createdAt),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(post.content),
              if (post.mediaUrl != null) ...[
                const SizedBox(height: 8),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.image, size: 48, color: Colors.grey),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: onUpvote,
                    icon: const Icon(Icons.arrow_upward_rounded),
                  ),
                  Text('${post.upvotes}'),
                  IconButton(
                    onPressed: onDownvote,
                    icon: const Icon(Icons.arrow_downward_rounded),
                  ),
                  Text('${post.downvotes}'),
                  const Spacer(),
                  IconButton(
                    onPressed: onComment,
                    icon: const Icon(Icons.mode_comment_outlined),
                  ),
                  IconButton(
                    onPressed: onShare,
                    icon: const Icon(Icons.ios_share_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _timeLabel(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
