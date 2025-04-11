import 'package:flutter/material.dart';
import '../utils/platform_utils.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/desktop_layout.dart';
import 'video_feed_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  // List of screens for each tab
  final List<Widget> _screens = [
    const VideoFeedScreen(),
    const Center(child: Text('Discover', style: TextStyle(color: Colors.white))),
    const SizedBox(), // Placeholder for create button (not a real tab)
    const Center(child: Text('Inbox', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Profile', style: TextStyle(color: Colors.white))),
  ];

  void _onItemTapped(int index) {
    // Handle create button (middle item) separately
    if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Create feature coming soon')),
      );
      return;
    }
    
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use different layouts based on platform
    if (PlatformUtils.isDesktop) {
      return DesktopLayout(
        selectedIndex: _selectedIndex,
        onNavigate: _onItemTapped,
      );
    } else {
      return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
    }
  }

  Widget _buildDesktopSidebar() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xFF1C1C1C),
          ),
          child: Text(
            'TikTok Clone',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home, color: Colors.white),
          title: const Text('Home', style: TextStyle(color: Colors.white)),
          selected: _selectedIndex == 0,
          onTap: () {
            _onItemTapped(0);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.explore, color: Colors.white),
          title: const Text('Discover', style: TextStyle(color: Colors.white)),
          selected: _selectedIndex == 1,
          onTap: () {
            _onItemTapped(1);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.add_circle, color: Colors.white),
          title: const Text('Create', style: TextStyle(color: Colors.white)),
          onTap: () {
            _onItemTapped(2);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.inbox, color: Colors.white),
          title: const Text('Inbox', style: TextStyle(color: Colors.white)),
          selected: _selectedIndex == 3,
          onTap: () {
            _onItemTapped(3);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.person, color: Colors.white),
          title: const Text('Profile', style: TextStyle(color: Colors.white)),
          selected: _selectedIndex == 4,
          onTap: () {
            _onItemTapped(4);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
