import 'dart:async';
import 'package:TinyTunes/res/components/Custom%20Divider/custom_divider.dart';
import 'package:flutter/material.dart';
import '../../app_colors/app_colors.dart';

class FeedLoadingEffect extends StatefulWidget {
  final bool isPlayer;
  const FeedLoadingEffect({super.key, required this.isPlayer});

  @override
  State<FeedLoadingEffect> createState() => _FeedLoadingEffectState();
}

class _FeedLoadingEffectState extends State<FeedLoadingEffect> {
  late Timer timer;
  bool isDim = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 900), (time) {
      setState(() {
        isDim = !isDim;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    // final height = MediaQuery.sizeOf(context).height * 1;
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
                padding: const EdgeInsets.only(left: 30),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 900),
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  width: widget.isPlayer ? width * .25 : width * .5,
                  decoration: BoxDecoration(
                      color: isDim
                          ? AppColors.loadingColor2
                          : AppColors.loadingColor1,
                      borderRadius: BorderRadius.circular(15)),
                ));
          } else if (index == 9) {
            return Padding(
                padding: const EdgeInsets.only(right: 30),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 900),
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  width: widget.isPlayer ? width * .25 : width * .5,
                  decoration: BoxDecoration(
                      color: isDim
                          ? AppColors.loadingColor2
                          : AppColors.loadingColor1,
                      borderRadius: BorderRadius.circular(15)),
                ));
          } else {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 900),
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              width: widget.isPlayer ? width * .25 : width * .5,
              decoration: BoxDecoration(
                  color:
                      isDim ? AppColors.loadingColor2 : AppColors.loadingColor1,
                  borderRadius: BorderRadius.circular(15)),
            );
          }
        },
        separatorBuilder: (context, val) {
          return CustomDivider.divider();
        },
        itemCount: 10);
  }
}
