import 'package:member_app/presentation/res/strings/values.dart';

class AddressModel {
  final String id;
  final String name;
  final String address;
  final String note;
  final double? lat;
  final double? lng;
  final String receiver;
  final String phone;

  const AddressModel({
    required this.id,
    required this.name,
    required this.address,
    required this.note,
    this.lat,
    this.lng,
    required this.receiver,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'note': note,
      'lat': lat,
      'lng': lng,
      'receiver': receiver,
      'phone': phone,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id']!,
      name: map['name'] ?? txtNone,
      address: map['address'] ?? txtNone,
      note: map['note'] ?? txtNone,
      lat: map['lat'] ?? 0,
      lng: map['lng'] ?? 0,
      receiver: map['receiver'] ?? txtNone,
      phone: map['phone'] ?? txtNone,
    );
  }
}