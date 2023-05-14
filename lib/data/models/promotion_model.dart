import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/supports/convert.dart';

class PromotionModel {
  final String id;
  final String name;
  final String? partnerImage;
  final String? backgroundImage;
  final int point;
  final int expire;
  final String partner;
  final String description;
  final DateTime from;
  final DateTime? to;
  final bool isFeatured;
  final int exchangeCount;
  // final int mark;

  const PromotionModel({
    required this.id,
    required this.name,
    this.partnerImage,
    this.backgroundImage,
    required this.point,
    required this.expire,
    required this.partner,
    required this.description,
    required this.from,
    required this.to,
    required this.isFeatured,
    required this.exchangeCount,
    // required this.mark,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'partnerImage': partnerImage,
      'backgroundImage': backgroundImage,
      'point': point,
      'expire': expire,
      'partner': partner,
      'description': description,
      'from': from.millisecondsSinceEpoch,
      'to': to?.millisecondsSinceEpoch,
      'isFeatured': isFeatured,
      'exchangeCount': exchangeCount,
      // 'mark': mark,
    };
  }

  String get expireName {
    int day = expire ~/ 24;
    return 'Sử dụng trong $day ngày';
  }

  factory PromotionModel.fromMap(Map<String, dynamic> map) {
    return PromotionModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
      partnerImage: map['partnerImage'],
      backgroundImage: map['backgroundImage'],
      point: map['point'] ?? 0,
      expire: map['expire'] ?? txtUnknown,
      partner: map['partner'] ?? txtAppName,
      description: map['description'] ?? txtDefault,
      from: map['from'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['from'])
          : DateTime.now(),
      to: map['to'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['to'])
          : null,
      isFeatured: map['isFeatured'] ?? false,
      exchangeCount: map['exchangeCount'] ?? 0,
      // mark: map['mark'] ?? 0,
    );
  }
}
