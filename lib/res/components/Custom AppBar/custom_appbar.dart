import 'package:TinyTunes/res/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/home_feed/bloc/home_bloc.dart';
import '../../../features/home_feed/bloc/home_event.dart';
import '../../app_colors/app_colors.dart';

class SliverBrukulAppBar extends StatelessWidget {
  final bool innerBoxIsScrolled;
  const SliverBrukulAppBar({
    super.key,
    required this.innerBoxIsScrolled,
  });

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.sizeOf(context).width * 1;
    return SliverAppBar(
      title: SizedBox(height: 150, child: Image.asset(AppAssets.textLogo)),
      pinned: false,
      floating: false,
      forceElevated: innerBoxIsScrolled,
    );
  }
}

class TinyTunesAppBars {
  static Widget homeAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(AppAssets.textLogo,
              height: 100, width: 200, fit: BoxFit.cover),
          GestureDetector(
              onTap: () {},
              child: const Icon(Icons.settings,
                  size: 25, color: AppColors.appWhite))
        ],
      ),
    );
  }

  static AppBar tinyTunesAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
          context
              .read<HomeBloc>()
              .add(const OnScreenChange(isFirstScreen: true));
        },
        color: AppColors.appWhite,
        icon: const Icon(Icons.arrow_back_rounded, size: 30),
      ),
      title: SizedBox(height: 150, child: Image.asset(AppAssets.textLogo)),
      // actions: const [CustomPopupMenu()]
    );
  }

  // static SliverAppBar categoriesAppBar() {
  //   return SliverAppBar(
  //       pinned: true,
  //       floating: false,
  //       flexibleSpace: ListView.separated(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: AppConstants.categoryListS.length,
  //           itemBuilder: (context, index) {
  //             if (index == 0) {
  //               return const SizedBox(width: 15);
  //             } else if (index == 8) {
  //               return const SizedBox();
  //             } else {
  //               return Container(
  //                 margin: const EdgeInsets.symmetric(vertical: 15),
  //                 padding: const EdgeInsets.symmetric(horizontal: 10),
  //                 decoration: BoxDecoration(
  //                   color: index == 1? AppColors.appWhite : AppColors.unselectedIconColor,
  //                   borderRadius: BorderRadius.circular(5),
  //                 ),
  //                 child: InkWell(
  //                   child: Center(
  //                     child: Text(AppConstants.categoryListS[index],
  //                         style: AppTextStyles.categoryStyle(
  //                           color: index == 1? AppColors.darkModeAppBarColor : AppColors.normalTextColorDark
  //                         )),
  //                   ),
  //                 ),
  //               );
  //             }
  //           },
  //           separatorBuilder: (context, indexS) {
  //             if (indexS == 0) {
  //               return const SizedBox();
  //             } else {
  //               return const SizedBox(width: 10);
  //             }
  //           }));
  // }
}
