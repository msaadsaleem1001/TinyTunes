
import 'package:equatable/equatable.dart';

abstract class AppPlayerEvent extends Equatable {

  const AppPlayerEvent();

  @override
  List<Object?> get props => [];

}

class OnVideoChange extends AppPlayerEvent{
  final String currentUrl;

  const OnVideoChange({required this.currentUrl});

  @override
  List<Object?> get props => [currentUrl];
}

class InitializePlayerScreen extends AppPlayerEvent{

  final String url;

  const InitializePlayerScreen({required this.url});

  @override
  List<Object?> get props => [url];

}

class OnFullScreenMode extends AppPlayerEvent{

  const OnFullScreenMode();

  @override
  List<Object?> get props => [];

}
