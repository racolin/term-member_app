part of 'auth_cubit.dart';


enum LoginType { init, login, logout, loading }

class AuthState extends Equatable {
  final LoginType loginType;

  const AuthState({required this.loginType});

  @override
  List<Object?> get props => [loginType];
}
