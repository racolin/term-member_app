part of '../cubits/internet_cubit.dart';

enum InternetType {
  connected, disconnected, loading
}

class InternetState {
  final InternetType type;
  InternetState({required this.type});
}

