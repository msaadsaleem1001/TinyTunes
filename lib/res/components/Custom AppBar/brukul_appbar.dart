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
    return SliverAppBar(
        title: const Text('Tiny Tunes'),
        pinned: false,
        floating: false,
        forceElevated: innerBoxIsScrolled);
  }
}

class BrukulAppBar {

  static AppBar brukulAppBar(BuildContext context){
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: (){
          GoRouter.of(context).pop();
          context.read<HomeBloc>().add(const OnScreenChange(isFirstScreen: true));
        },
        color: AppColors.appWhite,
        icon: const Icon(Icons.arrow_back_rounded, size: 30),
      ),
      title: const Text('Tiny Tunes'),
        // actions: const [CustomPopupMenu()]
    );
  }

}
