import 'package:member_app/presentation/res/strings/values.dart';

class AddressModel {
  final String id;
  final String name;
  final String address;
  final String note;
  final String? icon;
  final double? lat;
  final double? lng;
  final String receiver;
  final String phone;

  const AddressModel({
    required this.id,
    required this.name,
    required this.address,
    required this.note,
    this.icon,
    this.lat,
    this.lng,
    required this.receiver,
    required this.phone,
  });

  int get iconInt {
    return int.parse(icon ?? 'f02e', radix: 16);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'note': note,
      'icon': icon,
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
      icon: map['icon'],
      lat: map['lat'] == null ? 0 : map['lat'] is int ? (map['lat'] as int).toDouble() : map['lat'],
      lng: map['lng'] == null ? 0 : map['lng'] is int ? (map['lng'] as int).toDouble() : map['lng'],
      receiver: map['receiver'] ?? txtNone,
      phone: map['phone'] ?? txtNone,
    );
  }

  AddressModel copyWith({
    String? id,
    String? name,
    String? address,
    String? note,
    String? icon,
    double? lat,
    double? lng,
    String? receiver,
    String? phone,
  }) {
    return AddressModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      note: note ?? this.note,
      icon: icon ?? this.icon,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      receiver: receiver ?? this.receiver,
      phone: phone ?? this.phone,
    );
  }
}
