import 'package:TinyTunes/res/components/Custom%20AppBar/custom_appbar.dart';
import 'package:TinyTunes/res/components/Custom%20Divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../Data/Response/status.dart';
import '../../../res/components/Custom Thumbnail/custom_thumbnail.dart';
import '../../../res/components/Loading List/app_loading_effect.dart';
import '../../../res/utils/get video thumbnail/get_video_thumbnail.dart';
import '../../home_feed/bloc/home_bloc.dart';
import '../../home_feed/bloc/home_event.dart';
import '../../home_feed/bloc/home_state.dart';
import '../bloc/player_bloc.dart';
import '../bloc/player_event.dart';
import '../bloc/player_state.dart';

class VideoPlayerClass extends StatefulWidget {
  final String currentUrl;
  const VideoPlayerClass({super.key, required this.currentUrl});

  @override
  State<VideoPlayerClass> createState() => _VideoPlayerClassState();
}

class _VideoPlayerClassState extends State<VideoPlayerClass> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      autoPlay: true,
      params: const YoutubePlayerParams(
        strictRelatedVideos: true,
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
      videoId: YoutubePlayerController.convertUrlToId(widget.currentUrl,
          trimWhitespaces: true)!,
    );
    _controller.setFullScreenListener(
      (isFullScreen) {
        context
            .read<AppPlayerBloc>()
            .add(OnFullScreenMode(isFullScreen: isFullScreen));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.sizeOf(context).width * 1;
    // final height = MediaQuery.sizeOf(context).height * 1;
    return BlocBuilder<AppPlayerBloc, AppPlayerState>(
      // buildWhen: (previous, current) =>
      //     previous.isFullScreen != current.isFullScreen,
      builder: (context, state) {
        return BackButtonListener(
            onBackButtonPressed: () async {
              if (state.isFullScreen && !state.isFirstScreen) {
                _controller.exitFullScreen();
                context.read<HomeBloc>().add(const GetVideos());
                // BrukulDialog.showConfirmationDialog(context, _controller);
                return true;
              } else if (!state.isFirstScreen) {
                // debugPrint('Go Router Can Pop: ${GoRouter.of(context).canPop()}');
                GoRouter.of(context).pop();
                context
                    .read<HomeBloc>()
                    .add(const OnScreenChange(isFirstScreen: true));
                return true;
              } else {
                return true;
              }
            },
            child: Scaffold(
                appBar: state.isFullScreen
                    ? const PreferredSize(
                        preferredSize: Size(0, 0), child: SizedBox())
                    : TinyTunesAppBars.tinyTunesAppBar(context),
                body: YoutubePlayerScaffold(
                  enableFullScreenOnVerticalDrag: false,
                  autoFullScreen: false,
                  controller: _controller,
                  aspectRatio: 16 / 9,
                  builder: (context, player) {
                    return Column(
                      children: [
                        player,
                        Flexible(child: BlocBuilder<HomeBloc, HomeState>(
                          // buildWhen: (previous, current) => previous.feedList.length != current.feedList.length,
                          builder: (context, state) {
                            if (state.status == Status.COMPLETED) {
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.feedList.length,
                                itemBuilder: (context, index) {
                                  if (state.feedList[index].url ==
                                      widget.currentUrl) {
                                    return const SizedBox();
                                  } else {
                                    return CustomThumbnail(
                                        isPlayer: true,
                                        thumbnail:
                                        GetVideoThumbnail.getThumbnail(
                                            videoId: state
                                                .feedList[index]
                                                .videoId),
                                        url: state.feedList[index].url, duration: state.feedList[index].duration);
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  if (state.feedList[index].url ==
                                      widget.currentUrl) {
                                    return const SizedBox();
                                  } else {
                                    return CustomDivider.divider();                                  }
                                },
                              );
                            } else if (state.status == Status.LOADING) {
                              return const FeedLoadingEffect(isPlayer: true);
                            } else {
                              return const FeedLoadingEffect(isPlayer: true);
                            }
                          },
                        ))
                      ],
                    );
                  },
                )));
      },
    );
  }
}
