import 'package:flutter/material.dart';
import "../config/theme_constants.dart";
import '../models/video_model.dart';

class VideoInfo extends StatelessWidget {
  final VideoModel video;

  const VideoInfo({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: AppDimensions.leftMetadataPadding,
      bottom: AppDimensions.bottomMetadataPadding,
      right: 100, // Leave space for the action sidebar
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Caption
          Text(
            video.caption,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(1, 1),
                  blurRadius: 3,
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          
          // Hashtags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: video.hashtags.map((hashtag) {
              return _buildHashtagChip(hashtag);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHashtagChip(String hashtag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.standardRadius),
      ),
      child: Text(
        '#$hashtag',
        style: const TextStyle(
          color: AppColors.pink,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
