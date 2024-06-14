import 'package:TinyTunes/res/app_assets/app_assets.dart';
import 'package:TinyTunes/res/components/Custom%20AppBar/custom_appbar.dart';
import 'package:TinyTunes/res/components/Custom%20Divider/custom_divider.dart';
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
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<HomeBloc>().add(const GetVideos());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.hidden ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      debugPrint('App Exited');
    } else if (state == AppLifecycleState.paused) {
      debugPrint('App In Background');
    } else if (state == AppLifecycleState.resumed) {
      debugPrint('App Resumed');
    } else {
      debugPrint('State: ${state.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return BackButtonListener(
          onBackButtonPressed: () async {
            if (state.isFirstScreen) {
              context.read<HomeBloc>().add(const ShuffleList());
              return true;
            } else {
              GoRouter.of(context).pop();
              context
                  .read<HomeBloc>()
                  .add(const OnScreenChange(isFirstScreen: true));
              context
                  .read<HomeBloc>()
                  .add(const OnChangeBarView(bottomBarIndex: 0));
              return true;
            }
          },
          child: Scaffold(
            body: Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: .6,
                    image: AssetImage(AppAssets.bgImage), fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TinyTunesAppBars.homeAppBar(context),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state.status == Status.COMPLETED) {
                          return SizedBox(
                            width: width,
                            height: height * .45,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.feedList.length,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: CustomThumbnail(
                                          isPlayer: false,
                                          url: state.feedList[index].url,
                                          thumbnail:
                                              GetVideoThumbnail.getThumbnail(
                                                  videoId: state
                                                      .feedList[index].videoId),
                                          duration:
                                              state.feedList[index].duration,
                                        ));
                                  } else if (index ==
                                      state.feedList.length - 1) {
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: CustomThumbnail(
                                          isPlayer: false,
                                          url: state.feedList[index].url,
                                          thumbnail:
                                              GetVideoThumbnail.getThumbnail(
                                                  videoId: state
                                                      .feedList[index].videoId),
                                          duration:
                                              state.feedList[index].duration,
                                        ));
                                  } else {
                                    return CustomThumbnail(
                                      isPlayer: false,
                                      url: state.feedList[index].url,
                                      thumbnail: GetVideoThumbnail.getThumbnail(
                                          videoId:
                                              state.feedList[index].videoId),
                                      duration: state.feedList[index].duration,
                                    );
                                  }
                                },
                                separatorBuilder: (context, val) {
                                  return CustomDivider.divider();
                                }),
                          );
                        } else if (state.status == Status.LOADING) {
                          return const FeedLoadingEffect(isPlayer: false);
                        } else {
                          return const FeedLoadingEffect(isPlayer: false);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
