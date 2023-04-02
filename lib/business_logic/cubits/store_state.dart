import 'package:flutter/foundation.dart';

import '../../data/models/store_short_model.dart';

@immutable
abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<StoreShortModel> stores;
  final String searchKey;

  StoreLoaded({
    required this.stores,
    this.searchKey = '',
  });

  StoreLoaded copyWith({
    List<StoreShortModel>? stores,
    String? searchKey,
  }) {
    return StoreLoaded(
      stores: stores ?? this.stores,
      searchKey: searchKey ?? this.searchKey,
    );
  }

  List<StoreShortModel> getSearchStore() {
    return stores
        .where((e) =>
            e.name.contains(searchKey) || e.fullAddress.contains(searchKey))
        .toList();
  }
}
