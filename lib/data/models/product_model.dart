import 'package:member_app/presentation/res/strings/values.dart';

class ProductModel {
  final String id;
  final String name;
  final int cost;
  final String image;
  final List<String> images;
  final List<String> optionIds;
  final String description;

  const ProductModel({
    required this.id,
    required this.name,
    required this.cost,
    required this.image,
    required this.images,
    required this.optionIds,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cost': cost,
      'image': image,
      'images': images,
      'optionIds': optionIds,
      'description': description,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return ProductModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
      cost: map['cost'] ?? 0,
      image: map['image'],
      images: (map['images'] is List)
          ? (map['images'] as List).map<String>((e) => e as String).toList()
          : <String>[],
        optionIds: (map['optionIds'] is List)
            ? (map['optionIds'] as List).map<String>((e) => e as String).toList()
            : <String>[],
      description: map['description'] ?? txtDefault,
    );
  }
}
