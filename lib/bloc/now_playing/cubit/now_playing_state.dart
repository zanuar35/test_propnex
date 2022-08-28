part of 'now_playing_cubit.dart';

abstract class NowPlayingState extends Equatable {}

class NowPlayingInitial extends NowPlayingState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class NowPlayingLoading extends NowPlayingState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class NowPlayingSuccess implements NowPlayingState {
  final List result;
  const NowPlayingSuccess(this.result);

  @override
  List<Object?> get props => [result];

  @override
  bool? get stringify => true;
}

class NowPlayingFailed extends NowPlayingState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
