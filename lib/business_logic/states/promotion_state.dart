import 'package:flutter/foundation.dart';
import 'package:member_app/exception/app_message.dart';

import '../../presentation/res/strings/values.dart';
import '../../data/models/promotion_category_model.dart';
import '../../../data/models/promotion_model.dart';

@immutable
abstract class PromotionState {}

class PromotionInitial extends PromotionState {}

class PromotionLoading extends PromotionState {}

class PromotionLoaded extends PromotionState {
  final List<PromotionModel> promotions;
  final List<PromotionCategoryModel> categories;
  final int threshold;

  PromotionLoaded({
    required this.promotions,
    required this.categories,
    this.threshold = 0,
  });

  PromotionLoaded copyWith({
    List<PromotionModel>? promotions,
    List<PromotionCategoryModel>? categories,
    int? threshold,
  }) {
    return PromotionLoaded(
      promotions: promotions ?? this.promotions,
      categories: categories ?? this.categories,
    );
  }

  List<PromotionModel> getFromMe() {
    return promotions.where((e) => e.partner == txtAppName).toList();
  }

  List<PromotionModel> getFromPartner() {
    return promotions.where((e) => e.partner != txtAppName).toList();
  }

  List<PromotionModel> getByCategoryId(String id) {
    int index = categories.indexWhere((e) => e.id == id);
    if (index == -1) {
      return [];
    }
    return promotions
        .where(
          (e) => categories[index].promotionIds.contains(e.id),
        )
        .toList();
  }

  List<PromotionModel> getOutStanding() {
    return promotions.where((e) => e.isFeatured).toList();
  }
}

class PromotionFailure extends PromotionState {
  final AppMessage message;

  PromotionFailure({
    required this.message,
  });
}
