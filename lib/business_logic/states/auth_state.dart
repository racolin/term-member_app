abstract class AuthState {}

class AuthInitial extends AuthState {
  AuthInitial() {
    // printruntimeType);
  }
}

class AuthLogin extends AuthState {
  final String phone;
  AuthLogin({required this.phone}) {
    // printruntimeType);
  }
}
