
import 'package:member_app/presentation/res/strings/values.dart';

class StoreDetailModel {
  final String id;
  final String openTime;
  final String address;
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
    required this.address,
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
      'address': address,
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
    return StoreDetailModel(
      id: map['id'] as String,
      openTime: map['openTime'] ?? txtNone,
      address: map['address'] ?? txtNone,
      phone: map['phone'] ?? txtNone,
      lat: map['lat'],
      lng: map['lng'],
      images: map['images'] ?? [],
      unavailableProducts: map['unavailableProducts'] ?? [],
      unavailableOptions: map['unavailableOptions'] ?? [],
      unavailableCategories: map['unavailableCategories'] ?? [],
    );
  }
}
