import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(
          const AuthState(
            loginType: LoginType.init,
          ),
        );

  void tryLogin() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    _emitLogout();
  }

  void login(String email) async {
    _emitLoading();
    await Future.delayed(
      const Duration(seconds: 2),
    );
    _emitLogin();
  }

  void register(String email) async {
    _emitLoading();
    await Future.delayed(
      const Duration(seconds: 2),
    );

    _emitLogin();
  }

  void logout() async {
    _emitLoading();
    await Future.delayed(
      const Duration(seconds: 2),
    );
    _emitLogout();
  }

  void _emitLogin() => emit(const AuthState(loginType: LoginType.login));

  void _emitLogout() => emit(const AuthState(loginType: LoginType.logout));

  void _emitLoading() => emit(const AuthState(loginType: LoginType.loading));
}
