import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../bloc/short_bloc.dart';
import '../bloc/short_event.dart';

class SingleVideoComponent extends StatefulWidget {
  final String url;
  const SingleVideoComponent({super.key, required this.url});

  @override
  State<SingleVideoComponent> createState() => _SingleVideoComponentState();
}

class _SingleVideoComponentState extends State<SingleVideoComponent> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      autoPlay: true,
      params: const YoutubePlayerParams(
        strictRelatedVideos: false,
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
      videoId: YoutubePlayerController.convertUrlToId(
          widget.url,
          trimWhitespaces: true)!,
    );

    _controller.setFullScreenListener((isFullScreen) {
      context.read<ShortsBloc>().add(OnChangeScreenMode(isFullScreen: isFullScreen));
    });
  }

  @override
  void dispose() {
    _controller.pauseVideo();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      enableFullScreenOnVerticalDrag: false,
      autoFullScreen: false,
      controller: _controller,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return player;
      },
    );
  }
}
