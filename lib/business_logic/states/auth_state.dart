abstract class AuthState {}

class AuthInitial extends AuthState {
  AuthInitial() {
    print(runtimeType);
  }
}

class AuthLogin extends AuthState {
  final String phone;
  AuthLogin({required this.phone}) {
    print(runtimeType);
  }
}
