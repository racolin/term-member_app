import 'package:flutter/foundation.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/cart_template_model.dart';

@immutable
abstract class CartTemplateState {}

class CartTemplateInitial extends CartTemplateState {}

class CartTemplateLoading extends CartTemplateState {}

class CartTemplateLoaded extends CartTemplateState {
  final List<CartTemplateModel> list;
  final int limit;
  final CartTemplateModel? selected;

  CartTemplateLoaded({
    required this.list,
    this.limit = 0,
    this.selected,
  });

  bool get canCreate => list.length < limit;

  CartTemplateLoaded copyWith({
    List<CartTemplateModel>? list,
    int? limit,
    CartTemplateModel? selected,
  }) {
    return CartTemplateLoaded(
      list: list ?? this.list,
      limit: limit ?? this.limit,
      selected: selected ?? this.selected,
    );
  }
}

class CartTemplateFailure extends CartTemplateState {
  final AppMessage message;

  CartTemplateFailure({
    required this.message,
  });
}
