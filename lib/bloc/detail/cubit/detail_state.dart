part of 'detail_cubit.dart';

abstract class DetailState extends Equatable {}

class DetailInitial extends DetailState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class DetailLoading extends DetailState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class DetailSuccess extends DetailState {
  final DetailModel detailModel;
  DetailSuccess(this.detailModel);

  @override
  List<Object?> get props => [detailModel];
  // final List detailModel;
  // const DetailSuccess(this.detailModel)

  // @override
  // List<Object?> get props => [detailModel];

  @override
  bool? get stringify => true;
}

class DetailError extends DetailState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
