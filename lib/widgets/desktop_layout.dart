import 'package:flutter/material.dart';
import '../config/theme_constants.dart';
import '../screens/video_feed_screen.dart';

class DesktopLayout extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onNavigate;

  const DesktopLayout({
    super.key,
    required this.selectedIndex,
    required this.onNavigate,
  });

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // Left sidebar (vertical)
          _buildSidebar(),
          
          // Main content area
          Expanded(
            flex: 3,
            child: widget.selectedIndex == 0
                ? const VideoFeedScreen()
                : Center(
                    child: Text(
                      'Tab ${widget.selectedIndex + 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
          ),
          
          // Right metadata panel
          if (widget.selectedIndex == 0) _buildRightPanel(),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 80,
      color: AppColors.surface,
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildLogo(),
          const SizedBox(height: 40),
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.explore, 'Discover', 1),
          _buildNavItem(Icons.add_circle, 'Create', 2),
          _buildNavItem(Icons.inbox, 'Inbox', 3),
          _buildNavItem(Icons.person, 'Profile', 4),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        gradient: AppColors.pinkTealGradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'TT',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = widget.selectedIndex == index;
    
    return Tooltip(
      message: label,
      preferBelow: false,
      child: InkWell(
        onTap: () => widget.onNavigate(index),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            border: isSelected
                ? const Border(
                    left: BorderSide(
                      color: AppColors.pink,
                      width: 4,
                    ),
                  )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.pink : Colors.white,
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColors.pink : Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRightPanel() {
    // Sample comments for the right panel
    final comments = [
      {'user': 'Alex', 'comment': 'This is awesome! 🔥', 'time': '2m ago'},
      {'user': 'Jordan', 'comment': 'How did you do that?', 'time': '15m ago'},
      {'user': 'Taylor', 'comment': 'Love the music choice!', 'time': '32m ago'},
      {'user': 'Casey', 'comment': 'Amazing content as always', 'time': '1h ago'},
      {'user': 'Riley', 'comment': 'Need to try this 🙌', 'time': '3h ago'},
    ];

    return Container(
      width: 300,
      color: AppColors.surface,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Comments',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: comments.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                height: 24,
              ),
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.pink,
                      radius: 16,
                      child: Text(
                        comment['user']![0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                comment['user']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                comment['time']!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            comment['comment']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Add a comment...',
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: AppColors.background,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.standardRadius),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.send, color: AppColors.pink),
          onPressed: () {
            // Comment posting functionality would go here
          },
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
