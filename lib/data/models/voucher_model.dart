import 'dart:math';

import 'package:member_app/presentation/res/strings/values.dart';

class VoucherModel {
  final String id;
  final String code;
  final String name;
  final String? image;
  final String partner;
  final String? sliderImage;
  final DateTime from;
  final DateTime to;
  final DateTime? usedAt;
  final String description;

  const VoucherModel({
    required this.id,
    required this.code,
    required this.name,
    required this.image,
    required this.partner,
    required this.sliderImage,
    required this.from,
    required this.to,
    required this.usedAt,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'image': image,
      'partner': partner,
      'sliderImage': sliderImage,
      'from': from.millisecondsSinceEpoch,
      'to': to.millisecondsSinceEpoch,
      'usedAt': usedAt?.millisecondsSinceEpoch,
      'description': description,
    };
  }

  factory VoucherModel.fromMap(Map<String, dynamic> map) {
    return VoucherModel(
      id: map['id']!,
      code: map['code'] ?? txtUnknownCode,
      name: map['name'] ?? txtUnknown,
      image: map['image'],
      partner: map['partner'] ?? txtAppName,
      // sliderImage: map['sliderImage'],
      sliderImage: Random().nextBool() ? map['image'] : null,
      from: DateTime.tryParse(map['time'] ?? '') ?? DateTime.now(),
      // map['time'] == null
      //     ? DateTime.now()
      //     : DateTime.fromMillisecondsSinceEpoch(map['time']),
      to: DateTime.tryParse(map['time'] ?? '') ?? DateTime.now(),
      // map['time'] == null
      //     ? DateTime.now()
      //     : DateTime.fromMillisecondsSinceEpoch(map['time']),
      usedAt: DateTime.tryParse(map['time'] ?? ''),
      // map['time'] == null
      //     ? DateTime.now()
      //     : DateTime.fromMillisecondsSinceEpoch(map['time']),
      description: map['description'] ?? txtDefault,
    );
  }
}
