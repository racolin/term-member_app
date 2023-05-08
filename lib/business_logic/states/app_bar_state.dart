import 'package:flutter/foundation.dart';
import '../../data/models/app_bar_model.dart';
import '../../exception/app_message.dart';

@immutable
abstract class AppBarState {}

class AppBarInitial extends AppBarState {}

class AppBarLoading extends AppBarState {}

class AppBarLoaded extends AppBarState {
  final AppBarModel appBar;

  AppBarLoaded({
    required this.appBar,
  });

  AppBarLoaded copyWith({
    AppBarModel? appBar,
  }) {
    return AppBarLoaded(
      appBar: appBar ?? this.appBar,
    );
  }
}

class AppBarFailure extends AppBarState {
  final AppMessage message;

  AppBarFailure({
    required this.message,
  });
}
