import 'package:TinyTunes/features/home_feed/bloc/home_bloc.dart';

class PlayerArgs {
  final HomeBloc homeBloc;
  final String currentUrl;
  PlayerArgs({required this.homeBloc, required this.currentUrl});
}
