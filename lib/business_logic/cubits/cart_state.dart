
import '../../data/models/store_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final StoreModel? store;

  CartLoaded({
    this.store,
  });
}
