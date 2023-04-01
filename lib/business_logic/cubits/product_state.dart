import 'package:flutter/foundation.dart';

import '../../data/models/product_short_model.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductShortModel> products;

  ProductLoaded({
    required this.products,
  });

  List<ProductShortModel> getProductsByID(List<String> ids) {
    return products.where((e) => ids.contains(e.id)).toList();
  }
}