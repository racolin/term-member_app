import '../../data/models/store_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final StoreShortModel? store;

  CartLoaded({
    this.store,
  });

  CartLoaded copyWith({
    StoreShortModel? store,
  }) {
    return CartLoaded(
      store: store ?? this.store,
    );
  }
}
