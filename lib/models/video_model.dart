class VideoModel {
  final String id;
  final String caption;
  final List<String> hashtags;
  int likes;
  final String assetPath;
  bool isLiked;

  VideoModel({
    required this.id,
    required this.caption,
    required this.hashtags,
    required this.likes,
    required this.assetPath,
    this.isLiked = false,
  });

  // Toggle like status and update count
  void toggleLike() {
    isLiked = !isLiked;
    likes += isLiked ? 1 : -1;
  }
}

// Sample data for the app
List<VideoModel> sampleVideos = [
  VideoModel(
    id: "1",
    caption: "POV: You're the main character 🌟",
    hashtags: ["Viral", "FYP"],
    likes: 1420,
    assetPath: "assets/placeholders/placeholder_1.jpg",
  ),
  VideoModel(
    id: "2",
    caption: "Cooking fails be like... 😅",
    hashtags: ["FoodTok", "Relatable"],
    likes: 3821,
    assetPath: "assets/placeholders/placeholder_2.jpg",
  ),
  VideoModel(
    id: "3",
    caption: "When the beat drops just right ✨",
    hashtags: ["DanceChallenge", "CatVibes", "TechTips"],
    likes: 9274,
    assetPath: "assets/placeholders/placeholder_3.jpg",
  ),
];
