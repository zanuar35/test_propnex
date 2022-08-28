part of 'top_rated_cubit.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedInitial extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedSuccess extends TopRatedState {
  final List result;
  const TopRatedSuccess(this.result);

  @override
  List<Object> get props => [result];

  @override
  bool? get stringify => false;
}

class TopRatedFailed extends TopRatedState {}
