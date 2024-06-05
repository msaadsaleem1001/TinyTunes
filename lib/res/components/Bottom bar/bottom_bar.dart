import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../features/Shorts format Scroller/Shorts Args/shorts_args.dart';
import '../../../features/home_feed/bloc/home_bloc.dart';
import '../../../features/home_feed/bloc/home_event.dart';
import '../../../features/home_feed/bloc/home_state.dart';
import '../../app_assets/app_assets.dart';
import '../../app_colors/app_colors.dart';
import '../../routes/app_route_constants.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    // final height = MediaQuery.sizeOf(context).height * 1;
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (p, c) =>
          p.bottomBarIndex != c.bottomBarIndex || p.urlList != c.urlList,
      builder: (context, state) {
        return SafeArea(
          child: Container(
          width: width,
          height: 50,
          decoration: const BoxDecoration(color: AppColors.darkModeAppBarColor),
          child: Row(
            children: [
              Expanded(
                  child: Center(
                child: InkWell(
                  enableFeedback: false,
                  onTap: () {
                    if (state.bottomBarIndex == 1) {
                      context.read<HomeBloc>().add(const OnChangeBarView(bottomBarIndex: 0));
                      GoRouter.of(context).pop();
                    }
                  },
                  child: Icon(
                    Icons.home,
                    color: state.bottomBarIndex == 0
                        ? AppColors.appWhite
                        : AppColors.unselectedIconColor,
                    size: 35,
                  ),
                ),
              )),
              Expanded(
                child: Center(
                  child: InkWell(
                    enableFeedback: false,
                    onTap: () {
                      if(state.bottomBarIndex == 0){
                        context.read<HomeBloc>().add(const OnChangeBarView(bottomBarIndex: 1));
                        int savedIndex = 0;
                        if (state.shortsSavedIndex.isNotEmpty) {
                          savedIndex =
                              state.urlList.indexOf(state.shortsSavedIndex);
                        }
                        ShortsArgs shortsArgs = ShortsArgs(
                            urlList: state.urlList, savedIndex: savedIndex);
                        GoRouter.of(context).pushNamed(
                            AppRouteConstants.shorts,
                            extra: shortsArgs);

                      }
                      context
                          .read<HomeBloc>()
                          .add(const OnChangeBarView(bottomBarIndex: 1));
                    },
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: state.bottomBarIndex == 1
                            ? SvgPicture.asset(AppAssets.shorFormatSelected)
                            : SvgPicture.asset(AppAssets.shorFormat)),
                  ),
                ),
              )
            ],
          ),
        ));
      },
    );
  }
}
