import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AppVideoPlayer extends StatefulWidget {
  final String currentVideoId;
  const AppVideoPlayer({super.key, required this.currentVideoId});

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      autoPlay: true,
      params: const YoutubePlayerParams(
        strictRelatedVideos: false,
        showControls: true,
        mute: false,
        showFullscreenButton: false,
        loop: true,
      ),
      // videoId: YoutubePlayerController.convertUrlToId(widget.currentUrl, trimWhitespaces: true),
      videoId: widget.currentVideoId
    );
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.sizeOf(context).width * 1;
    // final height = MediaQuery.sizeOf(context).height * 1;
    return  YoutubePlayerScaffold(
      defaultOrientations: const [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ],
      enableFullScreenOnVerticalDrag: false,
      autoFullScreen: true,
      controller: _controller,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return player;
      },
    );
  }
}
