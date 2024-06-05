import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Data/Response/status.dart';
import '../../../res/app_colors/app_colors.dart';
import '../../../res/components/Bottom bar/bottom_bar.dart';
import '../../../res/components/Custom AppBar/brukul_appbar.dart';
import '../../../res/components/Custom Divider/custom_divider.dart';
import '../../../res/components/Custom Thumbnail/custom_thumbnail.dart';
import '../../../res/components/Error Widget/error_exception_widget.dart';
import '../../../res/components/Loading List/app_loading_effect.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  // final _androidAppRetain = const MethodChannel("android_app_retain");

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
    // final width = MediaQuery.sizeOf(context).width * 1;
    // final height = MediaQuery.sizeOf(context).height * 1;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return BackButtonListener(
            onBackButtonPressed: () async {
              if (state.isFirstScreen) {
                context.read<HomeBloc>().add(const GetVideos());
                // _androidAppRetain.invokeMethod("sendToBackground");
                // BrukulDialog.showDialogForMinimizeApp(context);
                return true;
              } else {
                GoRouter.of(context).pop();
                context.read<HomeBloc>().add(const OnScreenChange(isFirstScreen: true));
                return true;
              }
            },
            child: Scaffold(
                bottomNavigationBar: const CustomBottomBar(),
                body: SafeArea(
                    child: NestedScrollView(
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverBrukulAppBar(
                              innerBoxIsScrolled: innerBoxIsScrolled,
                            )
                          ];
                        },
                        body: CustomMaterialIndicator(
                          durations: const RefreshIndicatorDurations(
                              completeDuration: Duration(milliseconds: 1000)),
                          onRefresh: () async =>
                              context.read<HomeBloc>().add(const GetVideos()),
                          child: BlocBuilder<HomeBloc, HomeState>(
                            // buildWhen: (previous, current) =>
                            //     previous.feedList.length != current.feedList.length,
                            builder: (context, state) {
                              if (state.status == Status.COMPLETED) {
                                return ListView.separated(
                                    itemCount: state.feedList.length,
                                    itemBuilder: (context, index) {
                                      return CustomThumbnail(
                                          isPlayerScreen: false,
                                          url: state.feedList[index].url,
                                          thumbnail: state.feedList[index].thumbnail);
                                    },
                                    separatorBuilder: (context, val) {
                                      return const CustomDivider();
                                    });
                              } else if (state.status == Status.LOADING) {
                                return const FeedLoadingEffect();
                              } else {
                                return ExceptionMessageWidget(
                                    isPlayerScreen: false,
                                    msg: state.errorMsg,
                                    onTap: () {
                                      context
                                          .read<HomeBloc>()
                                          .add(const GetVideos());
                                    });
                              }
                            },
                          ),
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
                        )))));
      },
    );
  }
}
