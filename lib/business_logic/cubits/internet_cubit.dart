import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../states/internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _subscription;

  InternetCubit() : super(InternetState(type: InternetType.loading)) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) async {
      await Future.delayed(const Duration(seconds: 1));
      if (ConnectivityResult.none == event) {
        emit(InternetState(type: InternetType.disconnected));
      } else {
        emit(InternetState(type: InternetType.connected));
      }
    });
  }

  bool get hasInternet => InternetType.connected == state.type;

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
