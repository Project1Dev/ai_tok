import 'package:flutter/material.dart';

// Color palette
class AppColors {
  // Primary colors
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1C1C1C);
  
  // Accent colors
  static const Color pink = Color(0xFFEE1D52);
  static const Color teal = Color(0xFF69C9D0);
  
  // Text and icon colors
  static const Color white = Colors.white;
  static const Color grey = Color(0xFF8A8A8A);

  // Gradients
  static const LinearGradient pinkTealGradient = LinearGradient(
    colors: [pink, teal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [
      Color(0xFF1C1C1C),
      Color(0xFF2A2A2A),
      Color(0xFF1C1C1C),
    ],
    stops: [0.35, 0.5, 0.65],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// UI Constants
class AppDimensions {
  // Button sizes
  static const double actionButtonSize = 40.0;
  static const double createButtonSize = 50.0;
  
  // Paddings
  static const double pagePadding = 12.0;
  static const double bottomMetadataPadding = 48.0;
  static const double leftMetadataPadding = 24.0;
  
  // Border radius
  static const double standardRadius = 8.0;
}

// Animation durations
class AppDurations {
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
  static const Duration shimmerDuration = Duration(seconds: 3);
}
