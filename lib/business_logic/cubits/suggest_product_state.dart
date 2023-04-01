import 'package:flutter/foundation.dart';
import 'package:member_app/data/models/app_bar_model.dart';
import 'package:member_app/data/models/product_model.dart';

import '../../data/models/order_model.dart';
import 'home_state.dart';

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