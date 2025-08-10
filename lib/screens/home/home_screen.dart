import 'package:flutter/material.dart';
import '../../widgets/floating_nav_bar.dart';
import '../../widgets/post_card.dart';
import '../../models/post_model.dart';
import '../../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0; // 0: home, 1: chat, 2: profile
  String _filter = 'Latest';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusConnect'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Wrap(
              spacing: 8,
              children: ['Latest', 'Top', 'Announcements']
                  .map(
                    (e) => ChoiceChip(
                      label: Text(e),
                      selected: _filter == e,
                      onSelected: (_) => setState(() => _filter = e),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (_, i) => PostCard(
                post: PostModel(
                  id: '$i',
                  authorId: 'u1',
                  authorName: 'Student $i',
                  content: 'Sample post #$i for $_filter feed',
                  createdAt: DateTime.now().subtract(Duration(minutes: i * 5)),
                ),
                onTap: () => Navigator.pushNamed(context, AppRoutes.postDetail),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FloatingNavBar(
        currentIndex: _tab,
        onTap: (i) {
          setState(() => _tab = i);
          if (i == 1) Navigator.pushNamed(context, AppRoutes.chats);
          if (i == 2) Navigator.pushNamed(context, AppRoutes.profile);
        },
        onFab: () => Navigator.pushNamed(context, AppRoutes.createPost),
      ),
    );
  }
}
