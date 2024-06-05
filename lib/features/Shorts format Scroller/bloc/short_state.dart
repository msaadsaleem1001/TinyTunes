
import 'package:equatable/equatable.dart';

class ShortsState extends Equatable {

  final List<String> urlList;
  final bool isFullScreenMode;

  const ShortsState({
    this.urlList = const [],
    this.isFullScreenMode = false
  });

  ShortsState copyWith({List<String>? urlList, bool? isFullScreenMode}){
    return ShortsState(
      urlList: urlList ?? this.urlList,
      isFullScreenMode: isFullScreenMode ?? this.isFullScreenMode
    );
  }


  @override
  // TODO: implement props
  List<Object?> get props => [urlList, isFullScreenMode];
}
