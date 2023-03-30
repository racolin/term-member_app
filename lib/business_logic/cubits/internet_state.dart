part of 'internet_cubit.dart';

enum InternetType {
  connected, disconnected, loading
}

class InternetState {
  final InternetType internetType;
  InternetState({required this.internetType});
}

