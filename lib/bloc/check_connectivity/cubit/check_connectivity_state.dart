part of 'check_connectivity_cubit.dart';

abstract class CheckConnectivityState extends Equatable {
  const CheckConnectivityState();

  @override
  List<Object> get props => [];
}

class CheckConnectivityInitial extends CheckConnectivityState {}

class CheckConnectivitySuccess extends CheckConnectivityState {}

class CheckConnectivityFailure extends CheckConnectivityState {}

class CheckConnectivityLoading extends CheckConnectivityState {}
