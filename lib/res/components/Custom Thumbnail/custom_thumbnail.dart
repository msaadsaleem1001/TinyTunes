import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Firebase Analytics/firebase_analytics.dart';
import '../../../features/home_feed/bloc/home_bloc.dart';
import '../../../features/home_feed/bloc/home_event.dart';
import '../../routes/app_route_constants.dart';
import '../../utils/toast/toast.dart';

class CustomThumbnail extends StatefulWidget {
  final bool isPlayerScreen;
  final String url;
  final String thumbnail;
  const CustomThumbnail(
      {super.key,
      required this.url,
      required this.thumbnail,
      required this.isPlayerScreen});

  @override
  State<CustomThumbnail> createState() => _CustomThumbnailState();
}

class _CustomThumbnailState extends State<CustomThumbnail> {
  bool isVideoFound = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    // final height = MediaQuery.sizeOf(context).height * 1;
    return InkWell(
      enableFeedback: false,
      onTap: () {
        if (isVideoFound) {
          if (widget.isPlayerScreen) {
            FirebaseAnalyticsEvents.onTapOnVideoEvent();
            GoRouter.of(context).pop();
            GoRouter.of(context).pushNamed(AppRouteConstants.playerRoute,
                pathParameters: {'url': widget.url});
          } else {
            FirebaseAnalyticsEvents.onTapOnVideoEvent();
            context
                .read<HomeBloc>()
                .add(const OnScreenChange(isFirstScreen: false));
            GoRouter.of(context).pushNamed(AppRouteConstants.playerRoute,
                pathParameters: {'url': widget.url});
          }
        } else {
          AppToast.showToast(context: context, message: 'Video unavailable right now!');
        }
      },
      child: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        width: width,
        height: 220,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.thumbnail),
            fit: BoxFit.cover,
            onError: (obj, error){
              isVideoFound = false;
            }
          ),
        ),
        // child: Stack(
        //   children: [
        //     Positioned.fill(
        //         child: FadeInImage(
        //       fadeInDuration: Duration(milliseconds: 50),
        //       fadeOutDuration: Duration(milliseconds: 50),
        //       placeholder: const AssetImage(AppAssets.placeHolder),
        //       image: NetworkImage(widget.thumbnail),
        //       fit: BoxFit.cover,
        //       imageErrorBuilder: (context, object, error) {
        //         isVideoFound = false;
        //         return Container(
        //           padding: const EdgeInsets.only(bottom: 20),
        //           decoration: const BoxDecoration(
        //               image: DecorationImage(
        //                   image: AssetImage(AppAssets.videoErrorPlaceHolder))),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Text('Video Not Found',
        //                   style: AppTextStyles.subTitleStyle(color: AppColors.appBlack))
        //             ],
        //           ),
        //         );
        //       },
        //     )),
        //     // Positioned(
        //     //     top: 0,
        //     //     child: isVideoFound
        //     //         ? SizedBox(
        //     //       width: width,
        //     //       height: 220,
        //     //       child: const Center(
        //     //           child: CircleAvatar(
        //     //               radius: 20,
        //     //               backgroundColor: AppColors.appWhite,
        //     //               child: Center(
        //     //                 child: Icon(Icons.play_arrow,
        //     //                     size: 30, color: AppColors.darkModeScaffoldColor),
        //     //               )
        //     //           )
        //     //       ),
        //     //     )
        //     //         : const SizedBox()
        //     // ),
        //   ],
        // ),
      ),
    );
  }
}
