part of 'populer_cubit.dart';

abstract class PopulerState extends Equatable {
  const PopulerState();

  @override
  List<Object> get props => [];
}

class PopulerInitial extends PopulerState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class PopulerLoading extends PopulerState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class PopulerSuccess extends PopulerState {
  final List result;
  const PopulerSuccess(this.result);

  @override
  List<Object> get props => [result];

  @override
  bool? get stringify => false;
}

class PopulerFailed extends PopulerState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
