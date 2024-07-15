
import 'package:TinyTunes/features/splash/bloc/splash_bloc.dart';
import 'package:TinyTunes/features/splash/bloc/splash_event.dart';
import 'package:TinyTunes/res/app_assets/app_assets.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  final AudioHandler audioHandler;
  const SplashView({super.key, required this.audioHandler});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    final SplashBloc splashBloc = BlocProvider.of<SplashBloc>(context);
    splashBloc.add(OnSplashEvent(context: context, audioHandler: audioHandler));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AppAssets.splashImage), fit: BoxFit.cover)
        ),
      )
    );
  }
}

class TempSplashView extends StatelessWidget {
  const TempSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppAssets.splashImage), fit: BoxFit.cover)
            ),
          )
      )
    );
  }
}
