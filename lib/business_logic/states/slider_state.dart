import 'package:flutter/foundation.dart';
import 'package:member_app/exception/app_message.dart';

import '../../data/models/slider_model.dart';

@immutable
abstract class SliderState {}

class SliderInitial extends SliderState {}

class SliderLoading extends SliderState {}

class SliderLoaded extends SliderState {
  final List<SliderModel> list;
  final int index;

  SliderLoaded({
    required this.list,
    required this.index,
  });

  SliderLoaded copyWith({
    List<SliderModel>? list,
    int? index,
  }) {
    return SliderLoaded(
      list: list ?? this.list,
      index: index ?? this.index,
    );
  }
}

class SliderFailure extends SliderState {
  final AppMessage message;
  SliderFailure({required this.message}) {
    // printruntimeType);
  }
}