import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny_tunes/features/Shorts%20format%20Scroller/UI/single_video_component.dart';
import '../../../res/app_colors/app_colors.dart';
import '../../../res/components/Bottom bar/bottom_bar.dart';
import '../../../res/components/Loading List/shorts_loading.dart';
import '../../home_feed/bloc/home_bloc.dart';
import '../../home_feed/bloc/home_event.dart';
import '../Shorts Args/shorts_args.dart';
import '../bloc/short_bloc.dart';
import '../bloc/short_event.dart';
import '../bloc/short_state.dart';

class ShortFormatScroller extends StatefulWidget {
  final ShortsArgs? shortsArgs;

  const ShortFormatScroller({super.key, required this.shortsArgs});

  @override
  State<ShortFormatScroller> createState() => _ShortFormatScrollerState();
}

class _ShortFormatScrollerState extends State<ShortFormatScroller> {
  late PageController pageViewController;

  @override
  void initState() {
    context
        .read<ShortsBloc>()
        .add(ListInitialization(urls: widget.shortsArgs!.urlList));
    super.initState();
    pageViewController = PageController(
      initialPage: widget.shortsArgs!.savedIndex,
      keepPage: true,
      viewportFraction: 1.0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShortsBloc, ShortsState>(
      buildWhen: (p, c) => p.isFullScreenMode != c.isFullScreenMode,
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.appBlack,
            bottomNavigationBar:
                state.isFullScreenMode ? const SizedBox() : const CustomBottomBar(),
            body: SafeArea(
              child: SizedBox.expand(
                child: GestureDetector(
                  onVerticalDragUpdate: (details){
                    int sensitivity = 8;
                    if(details.delta.dy < -sensitivity){
                      pageViewController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInToLinear);
                      // BrukulToast.showToast(context: context, message: 'Swipe Up');
                    }else if(details.delta.dy > sensitivity){
                      pageViewController.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInToLinear);
                      // BrukulToast.showToast(context: context, message: 'Swipe down');
                    }else{}
                  },
                  child: BlocBuilder<ShortsBloc, ShortsState>(
                    buildWhen: (p, c) =>
                        p.urlList != c.urlList ||
                        p.isFullScreenMode != c.isFullScreenMode,
                    builder: (context, state) {
                      if (state.urlList.isNotEmpty) {
                        return PageView.builder(
                            onPageChanged: (index) {
                              context
                                  .read<HomeBloc>()
                                  .add(SaveShortsIndex(shortsIndex: index));
                            },
                            controller: pageViewController,
                            scrollDirection: state.isFullScreenMode
                                ? Axis.horizontal
                                : Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            // physics: state.isFullScreenMode
                            //     ? NeverScrollableScrollPhysics()
                            //     : ScrollPhysics(),
                            padEnds: false,
                            itemCount: state.urlList.length,
                            itemBuilder: (context, position) {
                              return SingleVideoComponent(
                                  url: state.urlList[position]);
                            });
                      } else {
                        return const ShortsLoading();
                      }
                    },
                  ),
                ),
              ),
            ));
      },
    );
  }
}
