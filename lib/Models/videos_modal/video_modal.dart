
class VideoModal {
  final int id;
  final String title;
  final String url;
  final String thumbnail;
  final String duration;
  final String category;
  final String lang;
  final String videoId;
  final String channelName;
  final String createdAt;

  const VideoModal({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnail,
    required this.duration,
    required this.category,
    required this.lang,
    required this.videoId,
    required this.channelName,
    required this.createdAt,
  });
}