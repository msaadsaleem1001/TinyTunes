
import 'package:equatable/equatable.dart';

class LoadingState extends Equatable {

  final bool isDim;

  const LoadingState({
    this.isDim = false,
  });

  LoadingState copyWith({bool? isDim}){
    return LoadingState(
      isDim: isDim ?? this.isDim,
    );
  }


  @override
  // TODO: implement props
  List<Object?> get props => [isDim];
}
