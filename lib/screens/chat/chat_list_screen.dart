import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search members',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (_, i) => ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text('Member $i'),
                subtitle: const Text('Last message preview...'),
                trailing: const Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 12,
                ),
                onTap: () => Navigator.pushNamed(context, AppRoutes.chatRoom),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
