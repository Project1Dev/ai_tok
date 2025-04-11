import 'package:flutter/material.dart';
import '../config/theme_constants.dart';
import '../models/video_model.dart';
import '../utils/platform_utils.dart';

class ActionSidebar extends StatelessWidget {
  final VideoModel video;
  final Function onLike;
  final Function onComment;
  final Function onShare;
  final Function onProfile;

  const ActionSidebar({
    super.key,
    required this.video,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: AppDimensions.pagePadding,
        top: AppDimensions.pagePadding + kToolbarHeight,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(
            icon: Icons.favorite,
            label: '${video.likes}',
            isActive: video.isLiked,
            activeColor: AppColors.pink,
            tooltip: 'Like',
            onTap: () => onLike(),
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            icon: Icons.comment,
            label: '246',
            tooltip: 'Comment',
            onTap: () => onComment(),
          ),
          const SizedBox(height: 16),
          _buildShareButton(),
          const SizedBox(height: 16),
          _buildProfileButton(),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    bool isActive = false,
    Color activeColor = AppColors.white,
    String? tooltip,
    required Function onTap,
  }) {
    final Widget button = Column(
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: isActive ? activeColor : AppColors.white,
            size: AppDimensions.actionButtonSize,
          ),
          onPressed: () => onTap(),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    return PlatformUtils.shouldShowTooltips && tooltip != null
        ? Tooltip(message: tooltip, child: button)
        : button;
  }

  Widget _buildShareButton() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: 1.0),
      duration: AppDurations.shortAnimation,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: _buildActionButton(
            icon: Icons.reply,
            label: 'Share',
            tooltip: 'Share',
            onTap: () {
              // Start scale animation
              onShare();
            },
          ),
        );
      },
    );
  }

  Widget _buildProfileButton() {
    return Column(
      children: [
        Container(
          width: AppDimensions.actionButtonSize,
          height: AppDimensions.actionButtonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.pinkTealGradient,
            border: Border.all(
              color: AppColors.white,
              width: 2,
            ),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.person,
              color: AppColors.white,
              size: 24,
            ),
            onPressed: () => onProfile(),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
