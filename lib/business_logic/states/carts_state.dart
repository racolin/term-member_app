import 'package:member_app/data/models/paging_model.dart';

import '../../data/models/cart_model.dart';
import '../../data/models/cart_status_model.dart';

abstract class CartsState {}

class CartsInitial extends CartsState {}

class CartsLoading extends CartsState {}

class CartsLoaded extends CartsState {
  final Map<String, PagingModel<CartModel>> listCarts;
  final List<CartStatusModel> statuses;

  CartsLoaded({
    required this.listCarts,
    required this.statuses,
  });

  CartsLoaded copyWith({
    Map<String, PagingModel<CartModel>>? listCarts,
    List<CartStatusModel>? statuses,
  }) {
    return CartsLoaded(
      listCarts: listCarts ?? this.listCarts,
      statuses: statuses ?? this.statuses,
    );
  }
}
