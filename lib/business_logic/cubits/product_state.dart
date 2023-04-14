import 'package:flutter/foundation.dart';

import '../../data/models/product_option_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/product_model.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> list;

  final ProductModel? selectedItem;

  ProductLoaded({
    required this.list,
    required this.optionList,
    this.selectedItem,
  });

  List<ProductModel> getProductsByID(List<String> ids) {
    return list.where((e) => ids.contains(e.id)).toList();
  }

  ProductLoaded copyWith({
    List<ProductModel>? list,
    List<ProductOptionModel>? optionList,
    ProductModel? selectedItem,
  }) {
    return ProductLoaded(
      list: list ?? this.list,
      selectedItem: selectedItem ?? this.selectedItem,
      optionList: optionList ?? this.optionList,
    );
  }
}