import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

class PlatformUtils {
  // Check if running on mobile platforms
  static bool get isMobile => 
      UniversalPlatform.isAndroid || 
      UniversalPlatform.isIOS;
  
  // Check if running on desktop platforms
  static bool get isDesktop => 
      UniversalPlatform.isWindows || 
      UniversalPlatform.isMacOS || 
      UniversalPlatform.isLinux || 
      kIsWeb;
  
  // Check for specific platforms
  static bool get isAndroid => UniversalPlatform.isAndroid;
  static bool get isIOS => UniversalPlatform.isIOS;
  static bool get isWeb => kIsWeb;
  
  // Get platform-specific font family
  static String get platformFontFamily => 
      UniversalPlatform.isIOS ? 'SF Pro' : 'Roboto';
  
  // Determine viewport fraction based on platform
  static double get pageViewportFraction => 
      isDesktop ? 0.8 : 0.95;
  
  // Determine if we should show tooltips (primarily for desktop)
  static bool get shouldShowTooltips => isDesktop;
}
