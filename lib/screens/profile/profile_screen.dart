import 'package:flutter/material.dart';
import '../../theme/theme_controller.dart';
import '../../services/auth_service.dart';
import '../../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) async {
    await AuthService().signOut();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: const [
              CircleAvatar(radius: 30, child: Icon(Icons.person)),
              SizedBox(width: 12),
              Expanded(child: Text('Student Name\nstudent@jklu.edu.in')),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Joined: Jan 1, 2025'),
          const Divider(height: 32),
          const Text('Your Posts'),
          const SizedBox(height: 8),
          ...List.generate(
            3,
            (i) => Card(
              child: ListTile(
                title: Text('Your post #$i'),
                trailing: const Icon(Icons.more_vert),
              ),
            ),
          ),
          const Divider(height: 32),
          const Text('Settings'),
          const SizedBox(height: 8),
          ValueListenableBuilder(
            valueListenable: ThemeController.instance.mode,
            builder: (context, mode, _) => SwitchListTile(
              title: const Text('Dark mode'),
              value: mode == ThemeMode.dark,
              onChanged: (v) => ThemeController.instance.setDark(v),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Logout'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
