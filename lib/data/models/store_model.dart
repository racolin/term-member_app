import 'package:member_app/presentation/res/strings/values.dart';

class StoreModel {
  final String id;
  final String? image;
  final String name;
  final int distance;
  final bool isFavorite;

  const StoreModel({
    required this.id,
    this.image,
    required this.name,
    required this.distance,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'distance': distance,
      'isFavorite': isFavorite,
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id']!,
      image: map['image'],
      name: map['name'] ?? txtUnknown,
      distance: map['distance'] ?? 0,
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}
