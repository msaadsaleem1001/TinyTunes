
import '../../res/app_constants/app_constants.dart';

class VideoModal {
  final int id;
  final String title;
  final String url;
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
    required this.duration,
    required this.category,
    required this.lang,
    required this.videoId,
    required this.channelName,
    required this.createdAt,
  });

  // Factory constructor to create from JSON
  factory VideoModal.fromJson(Map<String, dynamic> json) {
    return VideoModal(
      id: json[AppConstants.id],
      title: json[AppConstants.title],
      url: json[AppConstants.url],
      duration: json[AppConstants.duration],
      category: json[AppConstants.category],
      lang: json[AppConstants.lang],
      videoId: json[AppConstants.videoId],
      channelName: json[AppConstants.channelName],
      createdAt: json[AppConstants.createdAt],
    );
  }

}