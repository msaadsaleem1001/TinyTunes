import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../Data/Response/status.dart';
import '../../../res/app_colors/app_colors.dart';
import '../../../res/components/Custom AppBar/brukul_appbar.dart';
import '../../../res/components/Custom Divider/custom_divider.dart';
import '../../../res/components/Custom Thumbnail/custom_thumbnail.dart';
import '../../../res/components/Error Widget/error_exception_widget.dart';
import '../../../res/components/Loading List/app_loading_effect.dart';
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
                    : BrukulAppBar.brukulAppBar(context),
                body: YoutubePlayerScaffold(
                  enableFullScreenOnVerticalDrag: false,
                  autoFullScreen: false,
                  controller: _controller,
                  aspectRatio: 16 / 9,
                  builder: (context, player) {
                    return Column(
                      children: [
                        player,
                        const CustomDivider(),
                        Flexible(child: BlocBuilder<HomeBloc, HomeState>(
                          // buildWhen: (previous, current) => previous.feedList.length != current.feedList.length,
                          builder: (context, state) {
                            if (state.status == Status.COMPLETED) {
                              return CustomMaterialIndicator(
                                  durations: const RefreshIndicatorDurations(
                                      completeDuration:
                                          Duration(milliseconds: 1000)),
                                  onRefresh: () async => context
                                      .read<HomeBloc>()
                                      .add(const GetVideos()),
                                  indicatorBuilder: (BuildContext context,
                                      IndicatorController controller) {
                                    return const Center(
                                        child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 4,
                                                color: AppColors.appWhite)));
                                  },
                                  child: ListView.separated(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.feedList.length,
                                    itemBuilder: (context, index) {
                                      if (state.feedList[index].url ==
                                          widget.currentUrl) {
                                        return const SizedBox();
                                      } else {
                                        return CustomThumbnail(
                                            isPlayerScreen: true,
                                            thumbnail:
                                                state.feedList[index].thumbnail,
                                            url:
                                                state.feedList[index].url);
                                      }
                                    },
                                    separatorBuilder: (context, index) {
                                      if (state.feedList[index].url ==
                                          widget.currentUrl) {
                                        return const SizedBox();
                                      } else {
                                        return const CustomDivider();
                                      }
                                    },
                                  ));
                            } else if (state.status == Status.LOADING) {
                              return const FeedLoadingEffect();
                            } else {
                              return ExceptionMessageWidget(
                                  isPlayerScreen: true,
                                  msg: state.errorMsg,
                                  onTap: () {
                                    context
                                        .read<HomeBloc>()
                                        .add(const GetVideos());
                                  });
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
