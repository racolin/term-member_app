import 'package:flutter/foundation.dart';

import '../../data/models/product_model.dart';

@immutable
abstract class SuggestProductState {}

class SuggestProductInitial extends SuggestProductState {}

class SuggestProductLoading extends SuggestProductState {}

class SuggestProductLoaded extends SuggestProductState {
  final List<ProductModel> suggests;

  SuggestProductLoaded({
    required this.suggests,
  });
}