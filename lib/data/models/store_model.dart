class StoreModel {
  final String id;
  final String mainImage;
  final List<String> images;
  final String dailyTime;
  final AddressModel address;
  final String fullAddress;
  final String contact;
  final String brandName;
  final String distance;

  StoreModel({
    required this.id,
    required this.mainImage,
    required this.images,
    required this.dailyTime,
    required this.address,
    required this.fullAddress,
    required this.contact,
    required this.brandName,
    required this.distance,
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
