import 'package:member_app/data/models/product_short_model.dart';

import '../../presentation/res/strings/values.dart';

class ProductModel extends ProductShortModel {
  final List<String> images;
  final String description;
  final bool isFavorite;

  ProductModel({
    required super.id,
    required this.images,
    required super.mainImage,
    required super.name,
    required super.price,
    required this.description,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'images': images,
      'description': description,
      'isFavorite': isFavorite,
      'id': id,
      'name': name,
      'mainImage': mainImage,
      'price': price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? txtUnknown,
      name: map['name'] ?? txtUnknown,
      mainImage: map['mainImage'] ?? linkUnknownIcon,
      price: map['price'] ?? 0,
      images: map['images'] ?? [],
      description: map['description'] ?? txtUnknown,
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}
