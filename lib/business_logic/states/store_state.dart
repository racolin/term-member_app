import 'package:flutter/foundation.dart';
import 'package:member_app/data/models/store_detail_model.dart';
import 'package:member_app/exception/app_message.dart';

import '../../data/models/news_model.dart';
import '../../data/models/store_model.dart';

@immutable
abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<StoreModel> list;
  final StoreDetailModel? detail;

  StoreLoaded({
    required this.list,
    this.detail,
  });

  StoreLoaded copyWith({
    List<StoreModel>? list,
    StoreDetailModel? detail,
  }) {
    return StoreLoaded(
      list: list ?? this.list,
      detail: detail ?? this.detail,
    );
  }
}

class StoreFailure extends StoreState {
  final AppMessage message;
  StoreFailure({required this.message}) {
    print(runtimeType);
  }
}