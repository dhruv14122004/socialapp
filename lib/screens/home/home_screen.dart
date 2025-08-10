import 'package:flutter/material.dart';
import '../../widgets/post_card.dart';
import '../../widgets/floating_nav_bar.dart';
import '../../models/post_model.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0; // 0: home, 1: search, 2: chat, 3: favorites, 4: settings
  String _filter = 'Latest';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConst.appName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
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
                  padding: const EdgeInsets.only(
                    bottom: 100,
                  ), // Space for floating nav
                  itemCount: 6,
                  itemBuilder: (_, i) => PostCard(
                    post: PostModel(
                      id: '$i',
                      authorId: 'u1',
                      authorName: 'Student $i',
                      content: 'Sample post #$i for $_filter feed',
                      createdAt: DateTime.now().subtract(
                        Duration(minutes: i * 5),
                      ),
                    ),
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.postDetail),
                  ),
                ),
              ),
            ],
          ),
          // Floating Navigation Bar
          FloatingNavBar(
            currentIndex: _tab,
            onTap: (index) {
              setState(() => _tab = index);
              switch (index) {
                case 0:
                  // Home - already here
                  break;
                case 1:
                  // Search functionality
                  break;
                case 2:
                  Navigator.pushNamed(context, AppRoutes.chats);
                  break;
                case 3:
                  // Favorites - could navigate to saved posts
                  break;
                case 4:
                  Navigator.pushNamed(context, AppRoutes.profile);
                  break;
              }
            },
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90), // Move above nav bar
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.createPost),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
