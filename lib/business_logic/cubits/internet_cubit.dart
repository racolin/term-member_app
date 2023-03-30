import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> subscription;
  InternetCubit()
      : super(
          InternetState(
            internetType: InternetType.loading,
          ),
        ) {

    subscription = connectivity.onConnectivityChanged.listen((event) {
      if (ConnectivityResult.none == event) {
        emit(InternetState(internetType: InternetType.disconnected));
      } else {
        emit(InternetState(internetType: InternetType.connected));
      }
    });

  }

  void connected() => emit(
        InternetState(
          internetType: InternetType.connected,
        ),
      );

  void disconnected() => emit(
        InternetState(
          internetType: InternetType.disconnected,
        ),
      );

  void loading() => emit(
        InternetState(
          internetType: InternetType.loading,
        ),
      );
}
