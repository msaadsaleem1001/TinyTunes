import 'package:TinyTunes/Repository/Settings%20Repo/settings_repo.dart';
import 'package:TinyTunes/Unity%20Ads%20Services/unity_ads_services.dart';
import 'package:TinyTunes/res/Audio%20Background%20Services/audio_background_services.dart';
import 'package:TinyTunes/res/app_urls/app_urls.dart';
import 'package:TinyTunes/tiny_tunes_app.dart';
import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Firebase Analytics/firebase_analytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBD481hoWGins9sqRKRKjI5lra_0Nm8er0',
          appId: '1:768237634576:android:62c4ed7400f43fcbe23695',
          messagingSenderId: '',
          projectId: 'tinytunes-70470'));
  await FirebaseAnalyticsEvents.openAppEvent();
  await Supabase.initialize(
    url: AppUrls.supabaseUrl,
    anonKey: AppUrls.supabaseAnonKey,
  );
  await CategoryDatabase.init();
  final AudioHandler audioHandler = await InitializeAudioHandler.init();
  await InterstitialUnityAdsManager.init();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(TinyTunesApp(audioHandler: audioHandler));
  });
}