import 'package:flutter/foundation.dart';
import 'package:member_app/data/models/app_bar_model.dart';

import '../../data/models/order_model.dart';
import 'home_state.dart';

@immutable
abstract class ReOrderState {}

class ReOrderInitial extends ReOrderState {}

class ReOrderLoading extends ReOrderState {}

class ReOrderLoaded extends ReOrderState {
  final List<OrderModel> orders;

  ReOrderLoaded({
    required this.orders,
  });
}