part of 'store_bloc.dart';


@immutable
abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<StoreShortModel> stores;
  final List<StoreShortModel>? searchStores;

  StoreLoaded({
    required this.stores,
    this.searchStores,
  });

  StoreLoaded copyWith({
    List<StoreShortModel>? stores,
    List<StoreShortModel>? searchStores,
  }) {
    return StoreLoaded(
      stores: stores ?? this.stores,
      searchStores: searchStores ?? this.searchStores,
    );
  }
}
