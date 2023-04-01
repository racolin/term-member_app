import 'package:flutter/foundation.dart';

import '../../data/models/product_short_model.dart';

@immutable
abstract class SuggestProductState {}

class SuggestProductInitial extends SuggestProductState {}

class SuggestProductLoading extends SuggestProductState {}

class SuggestProductLoaded extends SuggestProductState {
  final List<ProductShortModel> suggests;

  SuggestProductLoaded({
    required this.suggests,
  });
}