import 'package:member_app/presentation/res/strings/values.dart';

class ProductShortModel {
  final String id;
  final String name;
  final String mainImage;
  final int price;

  ProductShortModel({
    required this.id,
    required this.name,
    required this.mainImage,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mainImage': mainImage,
      'price': price,
    };
  }

  factory ProductShortModel.fromMap(Map<String, dynamic> map) {
    return ProductShortModel(
      id: map['id'] ?? txtUnknown,
      name: map['name'] ?? txtUnknown,
      mainImage: map['mainImage'] ?? linkUnknownIcon,
      price: map['price'] ?? 0,
    );
  }
}
