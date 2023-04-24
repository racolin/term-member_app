import 'package:flutter/foundation.dart';
import 'package:member_app/exception/app_message.dart';
import '../../data/models/app_bar_model.dart';
import '../../data/models/history_point_model.dart';
import '../../data/models/paging_model.dart';

@immutable
abstract class HistoryPointState {}

class HistoryPointInitial extends HistoryPointState {}

class HistoryPointLoading extends HistoryPointState {}

class HistoryPointLoaded extends HistoryPointState {
  final PagingModel<HistoryPointModel> paging;

  HistoryPointLoaded({
    required this.paging,
  });

  HistoryPointLoaded copyWith({
    PagingModel<HistoryPointModel>? paging,
  }) {
    return HistoryPointLoaded(
      paging: paging ?? this.paging,
    );
  }
}

class HistoryPointFailure extends HistoryPointState {
  final AppMessage message;
  HistoryPointFailure({required this.message});
}