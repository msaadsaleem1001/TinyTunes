import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/home_feed/bloc/home_bloc.dart';
import '../../../features/home_feed/bloc/home_state.dart';
import '../../app_colors/app_colors.dart';

class CustomThumbnail extends StatefulWidget {
  final bool isPlayer;
  final String url;
  final String thumbnail;
  final String duration;
  const CustomThumbnail(
      {super.key,
      required this.url,
      required this.thumbnail,
      required this.isPlayer,
      required this.duration});

  @override
  State<CustomThumbnail> createState() => _CustomThumbnailState();
}

class _CustomThumbnailState extends State<CustomThumbnail> {
  bool isVideoFound = true;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.sizeOf(context).width * 1;
    // final height = MediaQuery.sizeOf(context).height * 1;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: (){},
          child: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            width: widget.isPlayer? 200 : 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.thumbnail),
                  fit: BoxFit.cover,
                  onError: (obj, error) {
                    isVideoFound = false;
                  }),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                // Positioned(
                //     top: 0,
                //     child: isVideoFound
                //         ? SizedBox(
                //       width: widget.isPlayer? 300 : 400,
                //       height: widget.isPlayer? 200 : 300,
                //       child: const Center(
                //           child: Center(
                //             child: Icon(Icons.play_arrow,
                //                 size: 40, color: AppColors.appWhite),
                //           )),
                //     )
                //         : const SizedBox()),
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
