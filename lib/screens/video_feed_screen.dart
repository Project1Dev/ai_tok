import 'package:flutter/material.dart';
import "../config/theme_constants.dart";
import '../models/video_model.dart';
import '../utils/platform_utils.dart';
import '../widgets/action_sidebar.dart';
import '../widgets/top_bar.dart';
import '../widgets/video_info.dart';
import '../widgets/video_player.dart';

class VideoFeedScreen extends StatefulWidget {
  const VideoFeedScreen({super.key});

  @override
  State<VideoFeedScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  List<VideoModel> _videos = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: PlatformUtils.pageViewportFraction,
      // Add initial page fraction for desktop platforms to create a better layout
      initialPage: PlatformUtils.isDesktop ? 1 : 0,
    );
    _videos = sampleVideos;
    
    // Precache all placeholder images
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var video in _videos) {
        precacheImage(AssetImage(video.assetPath), context);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Infinite scroll logic by cycling through placeholders
  void _onPageChanged(int index) {
    setState(() {
      // Get the actual index based on modulo
      _currentIndex = index % _videos.length;
      
      // If we're near the end, jump back to the beginning without animation
      if (index > (_videos.length * 2)) {
        _pageController.jumpToPage(index % _videos.length);
      }
    });
  }

  void _toggleLike(VideoModel video) {
    setState(() {
      video.toggleLike();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Main PageView for video feed
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final videoIndex = index % _videos.length;
              final video = _videos[videoIndex];
              
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Video player
                  VideoPlayer(
                    video: video,
                    isActive: _currentIndex == videoIndex,
                  ),
                  
                  // Video metadata at bottom
                  VideoInfo(video: video),
                  
                  // Right side action buttons
                  Align(
                    alignment: Alignment.centerRight,
                    child: ActionSidebar(
                      video: video,
                      onLike: () => _toggleLike(video),
                      onComment: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Comments coming soon')),
                        );
                      },
                      onShare: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Share feature coming soon')),
                        );
                      },
                      onProfile: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile feature coming soon')),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          
          // Top bar overlay
          const TopBar(),
        ],
      ),
    );
  }
}
