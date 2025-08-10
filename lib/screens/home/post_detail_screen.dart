import 'package:flutter/material.dart';
import '../../widgets/comment_tile.dart';
import '../../models/comment_model.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('Full post content would appear here'),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (_, i) => CommentTile(
                comment: CommentModel(
                  id: '$i',
                  postId: 'p1',
                  authorId: 'u$i',
                  authorName: 'User $i',
                  content: 'Comment number $i',
                  createdAt: DateTime.now().subtract(Duration(minutes: i * 3)),
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Write a comment',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
