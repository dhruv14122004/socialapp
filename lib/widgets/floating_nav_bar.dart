import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onFab;

  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onFab,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(height: 72),
        Positioned(
          bottom: 10,
          left: 16,
          right: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _NavIcon(
                  icon: Icons.home_rounded,
                  active: currentIndex == 0,
                  onTap: () => onTap(0),
                ),
                _NavIcon(
                  icon: Icons.chat_bubble_rounded,
                  active: currentIndex == 1,
                  onTap: () => onTap(1),
                ),
                const SizedBox(width: 56),
                _NavIcon(
                  icon: Icons.person_rounded,
                  active: currentIndex == 2,
                  onTap: () => onTap(2),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 26,
          child: FloatingActionButton.large(
            onPressed: onFab,
            heroTag: 'create-post',
            backgroundColor: AppColors.royalBlue,
            child: const Icon(Icons.add_circle_rounded, size: 36),
          ),
        ),
      ],
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: active ? AppColors.royalBlue : Colors.grey,
        size: 28,
      ),
    );
  }
}
