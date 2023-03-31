import 'package:flutter/foundation.dart';
import 'package:member_app/data/models/app_bar_model.dart';

import 'home_state.dart';

@immutable
abstract class AppBarState {}

class AppBarInitial extends AppBarState {}

class AppBarLoading extends AppBarState {}

class AppBarLoaded extends AppBarState {
  final AppBarModel appBar;
  final HomeBodyType type;
  final String label;

  AppBarLoaded({
    required this.appBar,
    required this.label,
    required this.type,
  });

  AppBarLoaded copyWith({
    AppBarModel? appBar,
    HomeBodyType? type,
    String? label,
  }) {
    return AppBarLoaded(
      appBar: appBar ?? this.appBar,
      type: type ?? this.type,
      label: label ?? this.label,
    );
  }
}