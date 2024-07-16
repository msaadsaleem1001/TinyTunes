import 'package:TinyTunes/features/home_feed/bloc/home_bloc.dart';

class PlayerArgs {
  final HomeBloc homeBloc;
  final String videoId;
  PlayerArgs({required this.homeBloc, required this.videoId});
}
