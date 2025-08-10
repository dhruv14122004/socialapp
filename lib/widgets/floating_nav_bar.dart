import 'package:flutter/material.dart';

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
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
            _NavIcon(
              icon: Icons.home_rounded,
              active: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavIcon(
              icon: Icons.search_rounded,
              active: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            _NavIcon(
              icon: Icons.chat_bubble_rounded,
              active: currentIndex == 2,
              onTap: () => onTap(2),
            ),
            _NavIcon(
              icon: Icons.favorite_rounded,
              active: currentIndex == 3,
              onTap: () => onTap(3),
            ),
            _NavIcon(
              icon: Icons.settings_rounded,
              active: currentIndex == 4,
              onTap: () => onTap(4),
            ),
          ],
        ),
      ),
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
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Icon(
          icon,
          color: active ? Colors.white : Colors.grey.shade400,
          size: 24,
        ),
      ),
    );
  }
}
