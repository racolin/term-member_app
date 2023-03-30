import 'package:flutter/foundation.dart';
import 'package:member_app/business_logic/cubits/app_bar_model.dart';

@immutable
abstract class AppBarState {}

class AppBarInitial extends AppBarState {}

class AppBarLoading extends AppBarState {}

class AppBarInfo extends AppBarState {
  final AppBarModel appBar;

  AppBarInfo({
    required this.appBar,
  });
}

class AppBarAction extends AppBarState {
  final String label;

  AppBarAction({
    required this.label,
  });
}
