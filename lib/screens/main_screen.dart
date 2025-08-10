import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../models/post_model.dart';
import '../routes/app_routes.dart';
import 'chat/chat_list_screen.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<PostModel> _samplePosts;

  // Create screens only once and keep them alive
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    // Create sample data once at the MainScreen level
    _samplePosts = List.generate(
      6,
      (i) => PostModel(
        id: '$i',
        authorId: 'u1',
        authorName: 'Student $i',
        content: 'Sample post #$i for testing',
        createdAt: DateTime.now().subtract(Duration(minutes: i * 5)),
        upvotes: (i + 1) * 3,
        downvotes: i,
        liked: i % 3 == 0, // Make every 3rd post liked for testing
      ),
    );

    _screens = [
      HomeTabScreen(posts: _samplePosts, onLike: _toggleLike),
      const SearchScreen(),
      const ChatListScreen(),
      FavoritesScreen(posts: _samplePosts),
      const ProfileScreen(),
    ];
  }

  void _toggleLike(int index) {
    setState(() {
      _samplePosts[index] = _samplePosts[index].copyWith(
        liked: !_samplePosts[index].liked,
      );
    });
  }

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get system navigation bar height
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final systemNavBarHeight = MediaQuery.of(context).padding.bottom;
    final safeAreaBottom = bottomPadding > 0
        ? bottomPadding
        : systemNavBarHeight;

    return Scaffold(
      body: Stack(
        children: [
          // Use IndexedStack instead of PageView for better performance
          RepaintBoundary(
            child: IndexedStack(index: _currentIndex, children: _screens),
          ),
          Positioned(
            bottom: safeAreaBottom + 10, // Reduced margin from 20 to 10
            left: 20,
            right: 20,
            child: RepaintBoundary(
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildNavIcon(Icons.home_rounded, 0),
                    _buildNavIcon(Icons.search_rounded, 1),
                    _buildNavIcon(Icons.chat_bubble_rounded, 2),
                    _buildNavIcon(Icons.favorite_rounded, 3),
                    _buildNavIcon(Icons.settings_rounded, 4),
                  ],
                ),
              ),
            ), // RepaintBoundary for nav
          ), // RepaintBoundary for IndexedStack
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom:
              safeAreaBottom +
              80, // Reduced from 90 to 80 to match nav bar spacing reduction
        ), // Adjust FAB position too
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.createPost),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    final isActive = _currentIndex == index;
    return InkWell(
      onTap: () => _onTabTapped(index),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Icon(
          icon,
          color: isActive ? Colors.white : Colors.grey.shade400,
          size: 24,
        ),
      ),
    );
  }
}

// Home tab content (extracted from HomeScreen)
class HomeTabScreen extends StatefulWidget {
  final List<PostModel> posts;
  final Function(int) onLike;

  const HomeTabScreen({super.key, required this.posts, required this.onLike});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen>
    with AutomaticKeepAliveClientMixin {
  String _filter = 'Latest';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  // Create filter chips once
  static const _filterOptions = ['Latest', 'Top', 'Announcements'];

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Wrap(
        spacing: 8,
        children: _filterOptions
            .map(
              (filter) => ChoiceChip(
                label: Text(filter),
                selected: _filter == filter,
                onSelected: (_) => setState(() => _filter = filter),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    // Calculate safe area for system navigation bar
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final systemNavBarHeight = MediaQuery.of(context).padding.bottom;
    final safeAreaBottom = bottomPadding > 0
        ? bottomPadding
        : systemNavBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: const Text('hotlines'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: safeAreaBottom + 95),
              itemCount: widget.posts.length,
              // Performance optimizations
              cacheExtent: 400, // Pre-cache items
              physics: const ClampingScrollPhysics(),
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
              addSemanticIndexes: false,
              itemBuilder: (context, i) => PostCard(
                key: ValueKey('post_$i'), // Add key for better performance
                post: widget.posts[i],
                onTap: () => Navigator.pushNamed(context, AppRoutes.postDetail),
                onLike: () => widget.onLike(i),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Search screen
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search posts, users...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const Expanded(
            child: Center(child: Text('Search results will appear here')),
          ),
        ],
      ),
    );
  }
}

// Favorites screen
class FavoritesScreen extends StatefulWidget {
  final List<PostModel> posts;

  const FavoritesScreen({super.key, required this.posts});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final likedPosts = widget.posts.where((post) => post.liked).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: likedPosts.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No saved posts yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    'Tap the heart icon on posts to save them here',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: likedPosts.length,
              itemBuilder: (context, index) => PostCard(
                key: ValueKey('liked_${likedPosts[index].id}'),
                post: likedPosts[index],
                onTap: () => Navigator.pushNamed(context, AppRoutes.postDetail),
              ),
            ),
    );
  }
}
