import 'package:campusconnect/UI/directmessage/directmessagemain.dart';
import 'package:campusconnect/UI/gangs/gangsmain.dart';
import 'package:campusconnect/UI/homepage/homemain.dart';
import 'package:campusconnect/UI/searchpage/searchmain.dart';
import 'package:campusconnect/UI/swipmian.dart/swipmain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentpage = 0;
  bool isPrivate = false;
  List<Widget> pages = [
    HomeMain(),
    Swipmain(),
    Gangsmain(),
    Searchmain(),
    Directmessagemain(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 50,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.person),
          iconSize: 25,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, size: 25),
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
        title: Text("hotline", style: Theme.of(context).textTheme.titleLarge,),
        centerTitle: true,
      ),
      body: Column(children: [Expanded(child: pages[currentpage])]),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentpage,
        onTap: (value) {
          setState(() {
            currentpage = value;
          });
        },
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<NavigationItem> _navigationItems = [
    NavigationItem(Icons.home, 'Home', false),
    NavigationItem(Icons.swipe, 'Swipe', false),
    NavigationItem(Icons.group, 'Gangs', false),
    NavigationItem(Icons.search, 'Search', false),
    NavigationItem(FontAwesomeIcons.message, 'Chat', true),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _navigationItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return _buildNavItem(index, item);
        }).toList(),
      ),
    );
  }

  Widget _buildNavItem(int index, NavigationItem item) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Stack(
          children: [
            Icon(
              item.icon,
              color: isActive ? Color(0xFF667EEA) : Color(0xFF9CA3AF),
              size: isActive ? 28 : 24,
            ),
            if (item.hasNotification)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: item.badgeCount != null && item.badgeCount! > 0
                      ? 18
                      : 12,
                  height: item.badgeCount != null && item.badgeCount! > 0
                      ? 18
                      : 12,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF2C3E50), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red,
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: item.badgeCount != null && item.badgeCount! > 0
                      ? Center(
                          child: Text(
                            item.badgeCount! > 9 ? '9+' : '${item.badgeCount}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final bool hasNotification;
  final int? badgeCount;

  NavigationItem(
    this.icon,
    this.label,
    this.hasNotification, {
    this.badgeCount,
  });
}
