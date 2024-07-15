import 'package:TinyTunes/features/Player/bloc/player_bloc.dart';
import 'package:TinyTunes/res/app_assets/app_assets.dart';
import 'package:TinyTunes/res/components/Custom%20AppBar/custom_appbar.dart';
import 'package:TinyTunes/res/components/Custom%20Divider/custom_divider.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Data/Response/status.dart';
import '../../../res/components/Custom Thumbnail/custom_thumbnail.dart';
import '../../../res/components/Loading List/app_loading_effect.dart';
import '../../../res/utils/get video thumbnail/get_video_thumbnail.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeView extends StatefulWidget {
  final AudioHandler audioHandler;
  const HomeView({super.key, required this.audioHandler});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc();
    homeBloc.add(const GetVideos());
    widget.audioHandler.play();
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return BlocProvider(
      create: (context) => homeBloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return BackButtonListener(
              onBackButtonPressed: () async {
                // debugPrint('On tap back');
                if (state.isFirstScreen) {
                  // debugPrint('Is first Screen? ${state.isFirstScreen}');
                  homeBloc.add(const ShuffleList());
                  return true;
                } else {
                  // debugPrint('Not full Screen? ${state.isFirstScreen}');
                  if(GoRouter.of(context).canPop()){
                    GoRouter.of(context).pop();
                    homeBloc.add(const OnScreenChange(isFirstScreen: true));
                  }else{
                    homeBloc.add(const ShuffleList());
                  }
                  return true;
                }
              },
              child: Scaffold(
                extendBodyBehindAppBar: true,
                appBar: TinyTunesAppBars.homeAppBar(context, homeBloc),
                body: Container(
                  padding: const EdgeInsets.only(bottom: 30),
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: .6,
                        image: AssetImage(AppAssets.bgImage),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: width,
                        height: (width * .49) * 9 / 16,
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state.status == Status.COMPLETED) {
                              return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.feedList.length,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Padding(
                                          padding:
                                          const EdgeInsets.only(left: 30),
                                          child: CustomThumbnail(
                                            video: state.feedList[index],
                                            homeBloc: homeBloc,
                                            appPlayerBloc: AppPlayerBloc(),
                                            isPlayer: false,
                                            url: state.feedList[index].url,
                                            thumbnail: GetVideoThumbnail
                                                .getThumbnail(
                                                videoId: state
                                                    .feedList[index]
                                                    .videoId),
                                            duration: state
                                                .feedList[index].duration,
                                            audioHandler: widget.audioHandler,
                                          ));
                                    } else if (index ==
                                        state.feedList.length - 1) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30),
                                          child: CustomThumbnail(
                                            video: state.feedList[index],
                                            homeBloc: homeBloc,
                                            appPlayerBloc: AppPlayerBloc(),
                                            isPlayer: false,
                                            url: state.feedList[index].url,
                                            thumbnail: GetVideoThumbnail
                                                .getThumbnail(
                                                videoId: state
                                                    .feedList[index]
                                                    .videoId),
                                            duration: state
                                                .feedList[index].duration,
                                            audioHandler: widget.audioHandler,
                                          ));
                                    } else {
                                      return CustomThumbnail(
                                        video: state.feedList[index],
                                        homeBloc: homeBloc,
                                        appPlayerBloc: AppPlayerBloc(),
                                        isPlayer: false,
                                        url: state.feedList[index].url,
                                        thumbnail:
                                        GetVideoThumbnail.getThumbnail(
                                            videoId: state
                                                .feedList[index].videoId),
                                        duration:
                                        state.feedList[index].duration,
                                        audioHandler: widget.audioHandler,
                                      );
                                    }
                                  },
                                  separatorBuilder: (context, val) {
                                    return CustomDivider.divider();
                                  });
                            } else if (state.status == Status.LOADING) {
                              return const FeedLoadingEffect(isPlayer: false);
                            } else {
                              return const FeedLoadingEffect(isPlayer: false);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}