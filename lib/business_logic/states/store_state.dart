import 'package:flutter/foundation.dart';
import 'package:member_app/exception/app_message.dart';

import '../../data/models/news_model.dart';
import '../../data/models/store_model.dart';

@immutable
abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<StoreModel> list;
  final String? selectedId;

  StoreLoaded({
    required this.list,
    this.selectedId,
  });

  StoreLoaded copyWith({
    List<StoreModel>? list,
    String? selectedId,
  }) {
    return StoreLoaded(
      list: list ?? this.list,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}

class StoreFailure extends StoreState {
  final AppMessage message;
  StoreFailure({required this.message}) {
    print(runtimeType);
  }
}