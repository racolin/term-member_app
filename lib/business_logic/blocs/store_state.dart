part of 'store_bloc.dart';


@immutable
abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<StoreShortModel> stores;
  final List<StoreShortModel>? searchStores;
  final bool isReload;

  StoreLoaded({
    required this.stores,
    this.searchStores,
    this.isReload = false,
  });

  StoreLoaded copyWith({
    List<StoreShortModel>? stores,
    List<StoreShortModel>? searchStores,
    bool? isReload,
  }) {
    return StoreLoaded(
      stores: stores ?? this.stores,
      searchStores: searchStores ?? this.searchStores,
      isReload: isReload ?? this.isReload,
    );
  }
}
