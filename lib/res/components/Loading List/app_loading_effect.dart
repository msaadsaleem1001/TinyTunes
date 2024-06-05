import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_colors/app_colors.dart';
import '../Custom Divider/custom_divider.dart';
import 'Loading Bloc/loading_bloc.dart';
import 'Loading Bloc/loading_state.dart';

class FeedLoadingEffect extends StatefulWidget {
  const FeedLoadingEffect({super.key});

  @override
  State<FeedLoadingEffect> createState() => _FeedLoadingEffectState();
}

class _FeedLoadingEffectState extends State<FeedLoadingEffect> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .sizeOf(context)
        .width * 1;
    return ListView.separated(
        itemBuilder: (context, index) {
          return BlocBuilder<LoadingBloc, LoadingState>(
            builder: (context, state) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                height: 210,
                width: width,
                color: state.isDim? AppColors.loadingColor2 : AppColors.loadingColor1,
              );
            },
          );
        },
        separatorBuilder: (context, val) {
          return const CustomDivider();
        },
        itemCount: 10
    );
  }
}

