import 'package:member_app/presentation/res/strings/values.dart';

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
  final DateTime to;
  final int mark;

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
    required this.mark,
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
      'to': to.millisecondsSinceEpoch,
      'mark': mark,
    };
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
          : DateTime.now(),
      mark: map['mark'] ?? 0,
    );
  }
}
