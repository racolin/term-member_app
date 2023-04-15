import 'package:flutter/foundation.dart';
import 'package:member_app/exception/app_message.dart';
import '../../data/models/app_bar_model.dart';
import '../../data/models/history_point_model.dart';

@immutable
abstract class HistoryPointState {}

class HistoryPointInitial extends HistoryPointState {}

class HistoryPointLoading extends HistoryPointState {}

class HistoryPointLoaded extends HistoryPointState {
  final List<HistoryPointModel> list;
  final int maxCount;
  final int limit = 20;
  final int page;

  HistoryPointLoaded({
    required this.list,
    required this.maxCount,
    required this.page,
  });

  HistoryPointLoaded copyWith({
    List<HistoryPointModel>? list,
    int? maxCount,
    int? limit,
    int? page,
  }) {
    return HistoryPointLoaded(
      list: list ?? this.list,
      maxCount: maxCount ?? this.maxCount,
      page: page ?? this.page,
    );
  }
}

class HistoryPointFailure extends HistoryPointState {
  final AppMessage message;
  HistoryPointFailure({required this.message});
}