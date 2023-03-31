import 'package:member_app/data/models/card_model.dart';

abstract class CardState {}

class CartInitial extends CardState {}

class CartLoading extends CardState {}

class CartLoaded extends CardState {
  final CardModel? cart;

  CartLoaded({
    this.cart,
  });
}
