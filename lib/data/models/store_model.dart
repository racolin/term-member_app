import 'package:member_app/data/models/store_short_model.dart';

class StoreModel extends StoreShortModel {
  final List<String> images;
  final String dailyTime;
  final AddressModel address;
  final String contact;

  StoreModel({
    required super.id,
    required super.mainImage,
    required this.images,
    required this.dailyTime,
    required this.address,
    required super.fullAddress,
    required this.contact,
    required super.name,
    required super.distance,
  });
}

class AddressModel {
  final String street;
  final String ward;
  final String district;
  final String city;
  final String country;

  AddressModel({
    required this.street,
    required this.ward,
    required this.district,
    required this.city,
    required this.country,
  });
}
