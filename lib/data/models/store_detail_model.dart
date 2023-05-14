
import 'package:member_app/presentation/res/strings/values.dart';

class StoreDetailModel {
  final String id;
  final String openTime;
  final String phone;
  final double? lat;
  final double? lng;
  final List<String> images;
  final List<String> unavailableProducts;
  final List<String> unavailableOptions;
  final List<String> unavailableCategories;

  const StoreDetailModel({
    required this.id,
    required this.openTime,
    required this.phone,
    this.lat,
    this.lng,
    required this.images,
    required this.unavailableProducts,
    required this.unavailableOptions,
    required this.unavailableCategories,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'openTime': openTime,
      'phone': phone,
      'lat': lat,
      'lng': lng,
      'images': images,
      'unavailableProducts': unavailableProducts,
      'unavailableOptions': unavailableOptions,
      'unavailableCategories': unavailableCategories,
    };
  }

  factory StoreDetailModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return StoreDetailModel(
      id: map['id'] as String,
      openTime: map['openTime'] ?? txtNone,
      phone: map['phone'] ?? txtNone,
      lat: map['lat'],
      lng: map['lng'],
      images: (map['images'] is List)
          ? (map['images'] as List).map<String>((e) => e as String).toList()
          : <String>[],
      unavailableProducts: (map['unavailableProducts'] is List)
          ? (map['unavailableProducts'] as List).map<String>((e) => e as String).toList()
          : <String>[],
      unavailableOptions: (map['unavailableOptions'] is List)
          ? (map['unavailableOptions'] as List).map<String>((e) => e as String).toList()
          : <String>[],
      unavailableCategories: (map['unavailableCategories'] is List)
          ? (map['unavailableCategories'] as List).map<String>((e) => e as String).toList()
          : <String>[],
    );
  }
}
