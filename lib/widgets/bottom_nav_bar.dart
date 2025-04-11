import 'package:flutter/material.dart';
import '../config/theme_constants.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.background,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.pink,
      unselectedItemColor: AppColors.grey,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: _buildCreateButton(),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.inbox),
          label: 'Inbox',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return Container(
      width: AppDimensions.createButtonSize,
      height: AppDimensions.createButtonSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.pinkTealGradient,
      ),
      child: const Icon(
        Icons.add,
        color: AppColors.white,
        size: 30,
      ),
    );
  }
}
