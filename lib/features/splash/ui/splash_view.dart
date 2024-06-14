
import 'package:TinyTunes/features/splash/bloc/splash_bloc.dart';
import 'package:TinyTunes/features/splash/bloc/splash_event.dart';
import 'package:TinyTunes/res/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(OnSplashEvent(context: context));
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          height: 250,
          child: Image.asset(AppAssets.logoTransparent),
        ),
      ),
    );
  }
}
