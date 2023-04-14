import 'package:member_app/presentation/res/strings/values.dart';

class PromotionCategoryModel {
  final int id;
  final String name;
  final String? image;
  final List<String> promotionIds;

  const PromotionCategoryModel({
    required this.id,
    required this.name,
    this.image,
    required this.promotionIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'promotionIds': promotionIds,
    };
  }

  factory PromotionCategoryModel.fromMap(Map<String, dynamic> map) {
    return PromotionCategoryModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
      image: map['image'],
      promotionIds: map['promotionIds'] ?? [],
    );
  }
}
