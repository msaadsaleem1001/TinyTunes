
class GetVideoThumbnail {

  static String getVideoThumbnail(String videoUrl){
    String? videoId = convertUrlToId(videoUrl);
    String thumbnailUrl = getThumbnail(videoId: videoId ?? "");
    // print(thumbnailUrl);
    return thumbnailUrl;
  }

  static String getYouTubeWatchUrl(String id) {
    return 'https://www.youtube.com/watch?v=$id';
  }

  static String getThumbnail({
    required String videoId,
    String quality = 'hqdefault',
    bool webp = false,
  }) =>
      webp
          ? 'https://i3.ytimg.com/vi_webp/$videoId/$quality.webp'
          : 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';

  static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

}