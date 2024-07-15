import 'package:TinyTunes/Firebase%20Analytics/firebase_analytics.dart';
import 'package:TinyTunes/Models/videos_model/video_model.dart';
import 'package:TinyTunes/features/Player/Player%20Args/player_args.dart';
import 'package:TinyTunes/features/Player/bloc/player_bloc.dart';
import 'package:TinyTunes/features/Player/bloc/player_event.dart';
import 'package:TinyTunes/features/home_feed/bloc/home_event.dart';
import 'package:TinyTunes/res/routes/app_route_constants.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/home_feed/bloc/home_bloc.dart';
import '../../../features/home_feed/bloc/home_state.dart';
import '../../app_colors/app_colors.dart';

class CustomThumbnail extends StatefulWidget {
  final VideoModel video;
  final HomeBloc homeBloc;
  final AppPlayerBloc appPlayerBloc;
  final bool isPlayer;
  final String url;
  final String thumbnail;
  final String duration;
  final AudioHandler audioHandler;
  const CustomThumbnail(
      {super.key,
      required this.video,
      required this.homeBloc,
      required this.appPlayerBloc,
      required this.url,
      required this.thumbnail,
      required this.isPlayer,
      required this.duration,
      required this.audioHandler});

  @override
  State<CustomThumbnail> createState() => _CustomThumbnailState();
}

class _CustomThumbnailState extends State<CustomThumbnail> {
  bool isVideoFound = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    // final height = MediaQuery.sizeOf(context).height * 1;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: (){
            if(widget.isPlayer){
              FirebaseAnalyticsEvents.selectedCategory(widget.video.category);
              FirebaseAnalyticsEvents.onTapOnVideoEvent();
              widget.homeBloc.add(CreateRecommendedList(video: widget.video));
              widget.appPlayerBloc.add(OnVideoChange(currentUrl: widget.url));
            }else{
              // debugPrint('Current url: ${widget.url}');
              FirebaseAnalyticsEvents.selectedCategory(widget.video.category);
              FirebaseAnalyticsEvents.onTapOnVideoEvent();
              widget.homeBloc.add(CreateRecommendedList(video: widget.video));
              widget.homeBloc.add(const OnScreenChange(isFirstScreen: false));
              PlayerArgs playerArgs = PlayerArgs(
                homeBloc: widget.homeBloc,
                currentUrl: widget.url,
              );
              GoRouter.of(context).pushNamed(
                  AppRouteConstants.playerRoute,
                  extra: playerArgs
              );
            }
          },
          child: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            width: widget.isPlayer? width * .25 : width * .5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Positioned.fill(child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.thumbnail,
                    width: widget.isPlayer? width * .25 : width * .5,
                    fit: BoxFit.cover
                  ),
                )),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: isVideoFound
                        ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      height: 20,
                      decoration:
                      const BoxDecoration(color: AppColors.appBlack),
                      child: Center(
                        child: Text(widget.duration),
                      ),
                    )
                        : const SizedBox()),
              ],
            )
          ),
        );
      },
    );
  }
}
