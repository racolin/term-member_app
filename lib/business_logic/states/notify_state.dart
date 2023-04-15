import 'package:flutter/foundation.dart';

import '../../exception/app_message.dart';
import '../../data/models/notify_model.dart';

@immutable
abstract class NotifyState {}

class NotifyInitial extends NotifyState {}

class NotifyLoading extends NotifyState {}

class NotifyLoaded extends NotifyState {
  final List<NotifyModel> list;

  NotifyLoaded({
    required this.list,
  });

  NotifyLoaded copyWith({
    List<NotifyModel>? list,
  }) {
    return NotifyLoaded(
      list: list ?? this.list,
    );
  }
}

class NotifyFailure extends NotifyState {
  final AppMessage message;
  NotifyFailure({required this.message}) {
    print(runtimeType);
  }
}