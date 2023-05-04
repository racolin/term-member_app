import 'package:member_app/exception/app_message.dart';

import '../../data/models/cart_detail_model.dart';

abstract class CartDetailState {}

class CartDetailInitial extends CartDetailState {}

class CartDetailLoading extends CartDetailState {}

class CartDetailLoaded extends CartDetailState {

  final CartDetailModel cart;

  CartDetailLoaded({
    required this.cart,
  });

  CartDetailLoaded copyWith({
    CartDetailModel? cart,
  }) {
    return CartDetailLoaded(
      cart: cart ?? this.cart,
    );
  }
}
class CartDetailFailure extends CartDetailState {
  final AppMessage? message;

  CartDetailFailure({
    this.message,
  });
}
