import 'package:member_app/exception/app_message.dart';

import '../../data/models/cart_template_model.dart';

abstract class CartTemplateState {}

class CartTemplateInitial extends CartTemplateState {}

class CartTemplateLoading extends CartTemplateState {}

class CartTemplateLoaded extends CartTemplateState {
  final List<CartTemplateModel> list;
  final int limit;

  CartTemplateLoaded({
    required this.list,
    this.limit = 0,
  });

  bool get canCreate => list.length < limit;

  CartTemplateLoaded copyWith({
    List<CartTemplateModel>? list,
    int? limit,
  }) {
    return CartTemplateLoaded(
      list: list ?? this.list,
      limit: limit ?? this.limit,
    );
  }
}

class CartTemplateFailure extends CartTemplateState {
  final AppMessage message;

  CartTemplateFailure({
    required this.message,
  });
}
