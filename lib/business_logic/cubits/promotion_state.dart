import 'package:flutter/foundation.dart';
import 'package:member_app/data/models/promotion_category_model.dart';
import '../../../data/models/promotion_model.dart';

@immutable
abstract class PromotionState {}

class PromotionInitial extends PromotionState {}

class PromotionLoading extends PromotionState {}

class PromotionLoaded extends PromotionState {
  final List<PromotionModel> promotions;
  final List<PromotionCategoryModel> categories;

  PromotionLoaded({
    required this.promotions,
    required this.categories,
  });

  PromotionLoaded copyWith({
    List<PromotionModel>? promotions,
    List<PromotionCategoryModel>? categories,
  }) {
    return PromotionLoaded(
      promotions: promotions ?? this.promotions,
      categories: categories ?? this.categories,
    );
  }

  List<PromotionModel> getFromMe() {
    return promotions.where((e) => e.from == 0).toList();
  }

  List<PromotionModel> getFromPartner() {
    return promotions.where((e) => e.from == 1).toList();
  }

  List<PromotionModel> getByCategoryId(int id) {
    return promotions.where((e) => e.categoryId == id).toList();
  }

  List<PromotionModel> getOutStanding(int threshold) {
    return promotions.where((e) => e.rate > threshold).toList();
  }
}
