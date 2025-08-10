import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/post_detail_screen.dart';
import '../screens/post/create_post_screen.dart';
import '../screens/chat/chat_list_screen.dart';
import '../screens/chat/chat_room_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/admin/admin_dashboard_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const postDetail = '/post';
  static const createPost = '/create-post';
  static const chats = '/chats';
  static const chatRoom = '/chat-room';
  static const profile = '/profile';
  static const admin = '/admin';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case postDetail:
        return MaterialPageRoute(builder: (_) => const PostDetailScreen());
      case createPost:
        return MaterialPageRoute(builder: (_) => const CreatePostScreen());
      case chats:
        return MaterialPageRoute(builder: (_) => const ChatListScreen());
      case chatRoom:
        return MaterialPageRoute(builder: (_) => const ChatRoomScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case admin:
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('404'))),
        );
    }
  }
}
