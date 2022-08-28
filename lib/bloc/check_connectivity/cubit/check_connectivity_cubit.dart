import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'check_connectivity_state.dart';

class CheckConnectivityCubit extends Cubit<CheckConnectivityState> {
  CheckConnectivityCubit() : super(CheckConnectivityInitial());

  void checkConnectivity() async {
    emit(CheckConnectivityLoading());
    ConnectivityResult result;
    Connectivity _connectivity = Connectivity();
    result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      emit(CheckConnectivitySuccess());
    } else if (result == ConnectivityResult.none) {
      emit(CheckConnectivityFailure());
    }
  }
}
