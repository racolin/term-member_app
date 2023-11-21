import 'package:member_app/presentation/res/strings/values.dart';

class StoreModel {
  final String id;
  final String? image;
  final String name;
  final String address;
  final double lat;
  final double lng;
  int? _distance;
  final bool isFavorite;

  StoreModel({
    required this.id,
    this.image,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.isFavorite,
  });

  int get distance => _distance ?? 0;

  set distance(int distance) => _distance = distance;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'address': address,
      'lng': lng,
      'lat': lat,
      'isFavorite': isFavorite,
    };
  }


  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id']!,
      image: map['image'],
      name: map['name'] ?? txtUnknown,
      address: map['address'] ?? txtUnknown,
      lng: map['lng'] ?? 0,
      lat: map['lat'] ?? 0,
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  StoreModel copyWith({
    String? id,
    String? image,
    String? name,
    String? address,
    double? lat,
    double? lng,
    bool? isFavorite,
  }) {
    return StoreModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
