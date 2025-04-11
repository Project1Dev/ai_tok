import 'package:flutter/material.dart';
import "../config/theme_constants.dart";

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.pagePadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Live button with gradient background
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppColors.pinkTealGradient,
                borderRadius: BorderRadius.circular(AppDimensions.standardRadius),
              ),
              child: const Text(
                'LIVE',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Search icon
            IconButton(
              icon: const Icon(
                Icons.search,
                color: AppColors.white,
                size: 24,
              ),
              tooltip: 'Search',
              onPressed: () {
                // TODO: Implement search functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Search feature coming soon')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
