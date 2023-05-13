import 'package:member_app/presentation/res/strings/values.dart';

class ProductCategoryModel {
  final String id;
  final String name;
  final String? image;
  final List<String> productIds;

  ProductCategoryModel({
    required this.id,
    required this.name,
    this.image,
    required this.productIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'productIds': productIds,
    };
  }

  factory ProductCategoryModel.fromMap(Map<String, dynamic> map) {
    return ProductCategoryModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
      image: map['image'],
      productIds: (map['productIds'] is List)
          ? (map['productIds'] as List).map<String>((e) => e as String).toList()
          : <String>[],
    );
  }
}