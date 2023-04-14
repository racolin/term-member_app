import 'package:flutter/foundation.dart';
import 'package:member_app/data/models/promotion_category_model.dart';
import '../../data/models/promotion_model.dart';
import '../../data/models/voucher_category_model.dart';
import '../../data/models/voucher_model.dart';

@immutable
abstract class VoucherState {}

class VoucherInitial extends VoucherState {}

class VoucherLoading extends VoucherState {}

class VoucherLoaded extends VoucherState {
  final List<VoucherModel> vouchers;
  final List<VoucherCategoryModel>? categories;

  VoucherLoaded({
    required this.vouchers,
    required this.categories,
  });

  VoucherLoaded copyWith({
    List<VoucherModel>? vouchers,
    List<VoucherCategoryModel>? categories,
  }) {
    return VoucherLoaded(
      vouchers: vouchers ?? this.vouchers,
      categories: categories ?? this.categories,
    );
  }

  List<VoucherModel> getByCategoryId(int id) {
    return vouchers.where((e) => e.categoryId == id).toList();
  }
}
