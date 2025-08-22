import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../models/post_model.dart';
import '../routes/app_routes.dart';
import '../services/post_service.dart';
import 'chat/chat_list_screen.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<PostModel> _posts = [];
  final PostService _postService = PostService();

  // Create screens only once and keep them alive
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      HomeTabScreen(posts: _posts, onLike: _toggleLike, onRefresh: _loadPosts),
      const SearchScreen(),
      const ChatListScreen(),
      FavoritesScreen(posts: _posts),
      const ProfileScreen(),
    ];

    _loadPosts();
  }

  Future<void> _loadPosts() async {
    try {
      final posts = await _postService.fetchPosts();
      if (mounted) {
        setState(() {
          _posts = posts;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading posts: ${e.toString()}')),
        );
      }
    }
  }

  void _toggleLike(int index) async {
    if (index >= 0 && index < _posts.length) {
      final post = _posts[index];
      try {
        await _postService.toggleLike(postId: post.id);

        // Update local state immediately for UI responsiveness
        setState(() {
          _posts[index] = _posts[index].copyWith(liked: !_posts[index].liked);
        });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating like: ${e.toString()}')),
          );
        }
      }
    }
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
  final Future<void> Function() onRefresh;

  const HomeTabScreen({
    super.key,
    required this.posts,
    required this.onLike,
    required this.onRefresh,
  });

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
            child: RefreshIndicator(
              onRefresh: widget.onRefresh,
              child: widget.posts.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.post_add, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No posts yet',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Text(
                            'Be the first to share something!',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(bottom: safeAreaBottom + 95),
                      itemCount: widget.posts.length,
                      // Performance optimizations
                      cacheExtent: 400, // Pre-cache items
                      physics: const AlwaysScrollableScrollPhysics(),
                      addAutomaticKeepAlives: true,
                      addRepaintBoundaries: true,
                      addSemanticIndexes: false,
                      itemBuilder: (context, i) => PostCard(
                        key: ValueKey('post_${widget.posts[i].id}'),
                        post: widget.posts[i],
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.postDetail),
                        onLike: () => widget.onLike(i),
                      ),
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
