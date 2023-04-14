import 'package:member_app/presentation/res/strings/values.dart';

class ProductCategoryModel {
  final String id;
  final String name;
  final String? image;
  final List<String> productIDs;

  ProductCategoryModel({
    required this.id,
    required this.name,
    this.image,
    required this.productIDs,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'productIDs': productIDs,
    };
  }

  factory ProductCategoryModel.fromMap(Map<String, dynamic> map) {
    return ProductCategoryModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
      image: map['image'],
      productIDs: map['productIDs'] ?? [],
    );
  }
}