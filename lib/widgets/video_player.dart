import 'package:flutter/material.dart';
import "../config/theme_constants.dart";
import '../models/video_model.dart';
import 'shimmer_effect.dart';

class VideoPlayer extends StatefulWidget {
  final VideoModel video;
  final bool isActive;

  const VideoPlayer({
    super.key,
    required this.video,
    this.isActive = false,
  });

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> with SingleTickerProviderStateMixin {
  bool _isPlaying = true;
  bool _isLoading = true;
  bool _showHeart = false;
  late AnimationController _playPauseController;
  late Animation<double> _playPauseAnimation;

  @override
  void initState() {
    super.initState();
    _playPauseController = AnimationController(
      vsync: this,
      duration: AppDurations.shortAnimation,
    );
    _playPauseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_playPauseController);

    // Simulate loading
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _playPauseController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Auto-play when this video becomes active
    if (widget.isActive && !oldWidget.isActive) {
      _resumeVideo();
    } else if (!widget.isActive && oldWidget.isActive) {
      _pauseVideo();
    }
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      
      if (_isPlaying) {
        _playPauseController.reverse();
        _resumeVideo();
      } else {
        _playPauseController.forward();
        _pauseVideo();
      }
    });
  }

  void _resumeVideo() {
    // In a real implementation, this would resume the video
    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseVideo() {
    // In a real implementation, this would pause the video
    setState(() {
      _isPlaying = false;
    });
  }

  void _showHeartAnimation() {
    setState(() {
      _showHeart = true;
    });
    
    Future.delayed(AppDurations.mediumAnimation, () {
      if (mounted) {
        setState(() {
          _showHeart = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause,
      onDoubleTap: _showHeartAnimation,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video placeholder
          _isLoading
              ? ShimmerEffect(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                )
              : Image.asset(
                  widget.video.assetPath,
                  fit: BoxFit.cover,
                ),
          
          // Play/Pause overlay
          AnimatedOpacity(
            opacity: _isPlaying ? 0.0 : 1.0,
            duration: AppDurations.shortAnimation,
            child: Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: Icon(
                  Icons.play_arrow,
                  color: AppColors.white,
                  size: 80,
                ),
              ),
            ),
          ),
          
          // Heart animation on double tap
          if (_showHeart)
            Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: AppDurations.mediumAnimation,
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.pink,
                      size: 100,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
