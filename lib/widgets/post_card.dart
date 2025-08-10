import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/post_model.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final VoidCallback? onTap;
  final VoidCallback? onShare;
  final VoidCallback? onComment;
  final VoidCallback? onUpvote;
  final VoidCallback? onDownvote;
  final VoidCallback? onLike;

  const PostCard({
    super.key,
    required this.post,
    this.onTap,
    this.onShare,
    this.onComment,
    this.onUpvote,
    this.onDownvote,
    this.onLike,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with AutomaticKeepAliveClientMixin {
  bool _upvoted = false;
  bool _downvoted = false;
  bool _liked = false;

  @override
  void initState() {
    super.initState();
    _liked = widget.post.liked;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const ClipOval(
                      child: CircleAvatar(
                        radius: 15,
                        child: Icon(Icons.person, size: 16),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.isAnonymous
                              ? 'Anonymous'
                              : '@${widget.post.authorName ?? 'user'}',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          _timeLabel(widget.post.createdAt),
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz),
                    ),
                  ],
                ),
                const Divider(color: Colors.black12),
                Text(widget.post.content),
                if (widget.post.mediaUrl != null) ...[
                  const SizedBox(height: 8),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: widget.post.mediaUrl!,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 250,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 250,
                          width: double.infinity,
                          color: Colors.black12,
                          child: const Center(
                            child: Icon(Icons.image, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                Row(
                  children: [
                    // Upvote button
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_upvoted) {
                            _upvoted = false;
                          } else {
                            _upvoted = true;
                            _downvoted = false; // Can't upvote and downvote
                          }
                        });
                        widget.onUpvote?.call();
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_up,
                        color: _upvoted ? Colors.green : Colors.grey,
                        size: 28,
                      ),
                    ),
                    Text(
                      '${widget.post.upvotes}',
                      style: TextStyle(
                        color: _upvoted ? Colors.green : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Downvote button
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_downvoted) {
                            _downvoted = false;
                          } else {
                            _downvoted = true;
                            _upvoted = false; // Can't upvote and downvote
                          }
                        });
                        widget.onDownvote?.call();
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: _downvoted ? Colors.red : Colors.grey,
                        size: 28,
                      ),
                    ),
                    Text(
                      '${widget.post.downvotes}',
                      style: TextStyle(
                        color: _downvoted ? Colors.red : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: widget.onComment,
                      icon: const Icon(Icons.comment),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _liked = !_liked;
                        });
                        if (widget.onLike != null) {
                          widget.onLike!();
                        }
                      },
                      icon: Icon(
                        _liked ? Icons.favorite : Icons.favorite_border,
                        color: _liked ? Colors.red : Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: widget.onShare,
                      icon: const Icon(Icons.share),
                    ),
                  ],
                ),
              ],
            ),
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
