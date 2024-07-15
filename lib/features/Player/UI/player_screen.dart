import 'package:TinyTunes/Data/Response/status.dart';
import 'package:TinyTunes/features/Player/Player%20Args/player_args.dart';
import 'package:TinyTunes/features/Player/UI/player.dart';
import 'package:TinyTunes/features/Player/bloc/player_bloc.dart';
import 'package:TinyTunes/features/Player/bloc/player_event.dart';
import 'package:TinyTunes/features/Player/bloc/player_state.dart';
import 'package:TinyTunes/features/home_feed/bloc/home_bloc.dart';
import 'package:TinyTunes/features/home_feed/bloc/home_state.dart';
import 'package:TinyTunes/res/app_colors/app_colors.dart';
import 'package:TinyTunes/res/components/Custom%20Divider/custom_divider.dart';
import 'package:TinyTunes/res/components/Custom%20Thumbnail/custom_thumbnail.dart';
import 'package:TinyTunes/res/components/Loading%20List/app_loading_effect.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../res/app_assets/app_assets.dart';
import '../../../res/utils/get video thumbnail/get_video_thumbnail.dart';
import '../../home_feed/bloc/home_event.dart';

class AppPlayerScreen extends StatefulWidget {
  final PlayerArgs? playerArgs;
  final AudioHandler audioHandler;
  const AppPlayerScreen(
      {super.key, required this.playerArgs, required this.audioHandler});

  @override
  State<AppPlayerScreen> createState() => _AppPlayerScreenState();
}

class _AppPlayerScreenState extends State<AppPlayerScreen> {
  late AppPlayerBloc appPlayerBloc;

  @override
  void initState() {
    super.initState();
    appPlayerBloc = AppPlayerBloc();
    appPlayerBloc
        .add(InitializePlayerScreen(url: widget.playerArgs!.currentUrl));
    widget.audioHandler.pause();
  }

  @override
  void dispose() {
    widget.audioHandler.play();
    super.dispose();
    appPlayerBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
            padding: EdgeInsets.zero,
            width: width,
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: .6,
                  image: AssetImage(AppAssets.bgImage),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                    child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocProvider(
                        create: (context) => appPlayerBloc,
                        child: BlocBuilder<AppPlayerBloc, AppPlayerState>(
                            builder: (context, state) {
                          if (state.status == Status.COMPLETED) {
                            return InkWell(
                              enableFeedback: false,
                              onDoubleTap: () {
                                // debugPrint('Double Tap!');
                                appPlayerBloc.add(const OnFullScreenMode());
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: state.isFullScreen ? 0 : 20,
                                    bottom: state.isFullScreen ? 0 : 10),
                                height:
                                    state.isFullScreen ? height : height * .63,
                                width: state.isFullScreen ? width : width * .7,
                                child: AppVideoPlayer(
                                    currentUrl: state.currentUrl),
                              ),
                            );
                          } else {
                            return Container(
                              height:
                                  state.isFullScreen ? height : height * .63,
                              width: state.isFullScreen ? width : width * .7,
                              decoration: const BoxDecoration(
                                color: AppColors.darkModeScaffoldColor,
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.appWhite,
                                  strokeWidth: 3,
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                      BlocProvider.value(
                        value: widget.playerArgs!.homeBloc,
                        child: Container(
                          margin: EdgeInsets.zero,
                          width: width,
                          height: (width * .25) * 9 / 16,
                          child: BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                            if (state.status == Status.COMPLETED) {
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.recommendedList.length,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: CustomThumbnail(
                                          video: state.recommendedList[index],
                                          homeBloc: widget.playerArgs!.homeBloc,
                                          appPlayerBloc: appPlayerBloc,
                                          isPlayer: true,
                                          url: state.recommendedList[index].url,
                                          thumbnail:
                                              GetVideoThumbnail.getThumbnail(
                                                  videoId: state
                                                      .recommendedList[index]
                                                      .videoId),
                                          duration: state
                                              .recommendedList[index].duration,
                                          audioHandler: widget.audioHandler,
                                        ));
                                  } else if (index ==
                                      state.recommendedList.length - 1) {
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: CustomThumbnail(
                                          video: state.recommendedList[index],
                                          homeBloc: widget.playerArgs!.homeBloc,
                                          appPlayerBloc: appPlayerBloc,
                                          isPlayer: true,
                                          url: state.recommendedList[index].url,
                                          thumbnail:
                                              GetVideoThumbnail.getThumbnail(
                                                  videoId: state
                                                      .recommendedList[index]
                                                      .videoId),
                                          duration: state
                                              .recommendedList[index].duration,
                                          audioHandler: widget.audioHandler,
                                        ));
                                  } else {
                                    return CustomThumbnail(
                                      video: state.recommendedList[index],
                                      homeBloc: widget.playerArgs!.homeBloc,
                                      appPlayerBloc: appPlayerBloc,
                                      isPlayer: true,
                                      url: state.recommendedList[index].url,
                                      thumbnail: GetVideoThumbnail.getThumbnail(
                                          videoId: state
                                              .recommendedList[index].videoId),
                                      duration:
                                          state.recommendedList[index].duration,
                                      audioHandler: widget.audioHandler,
                                    );
                                  }
                                },
                                separatorBuilder: (context, separatorIndex) {
                                  return CustomDivider.divider(player: true);
                                },
                              );
                            } else {
                              return const FeedLoadingEffect(isPlayer: true);
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                )),
                BlocProvider(
                  create: (context) => appPlayerBloc,
                  child: BlocBuilder<AppPlayerBloc, AppPlayerState>(
                    builder: (context, state) {
                      if(state.isFullScreen){
                        return const SizedBox();
                      }
                      else{
                        return Positioned(
                          top: 25,
                          left: 10,
                          child: IconButton(
                            onPressed: () {
                              GoRouter.of(context).pop();
                              widget.playerArgs!.homeBloc.add(const OnScreenChange(isFirstScreen: true));
                            },
                            icon: const Icon(Icons.arrow_back_ios_rounded,
                            size: 30, color: AppColors.appWhite)));
                      }
                    },
                  ),
                )
              ],
            )));
  }
}
