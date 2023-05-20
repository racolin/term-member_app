import '../../presentation/res/colors/colors.dart';
import '../../presentation/res/strings/values.dart';

class CardModel {
  final String id;
  final String code;
  final String name;
  final int point;
  final int currentPoint;
  final String currentRankName;
  final int currentRankPoint;
  final String nextRankName;
  final int nextRankPoint;
  final String? backgroundImage;
  final String description;
  final int color;
  final int fee;

  const CardModel({
    required this.id,
    required this.code,
    required this.name,
    required this.point,
    required this.currentPoint,
    required this.currentRankName,
    required this.currentRankPoint,
    required this.nextRankName,
    required this.nextRankPoint,
    this.backgroundImage,
    required this.description,
    required this.color,
    required this.fee,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'point': point,
      'currentPoint': currentPoint,
      'currentRankName': currentRankName,
      'currentRankPoint': currentRankPoint,
      'nextRankName': nextRankName,
      'nextRankPoint': nextRankPoint,
      'backgroundImage': backgroundImage,
      'description': description,
      'color': color,
      'fee': fee,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id']!,
      code: map['code'] ?? txtUnknownCode,
      name: map['name'] ?? txtUnknown,
      point: map['point'] ?? 0,
      currentPoint: map['currentPoint'] ?? 0,
      currentRankName: map['currentRankName'] ?? txtUnknown,
      currentRankPoint: map['currentRankPoint'] ?? 0,
      nextRankName: map['nextRankName'] ?? txtUnknown,
      nextRankPoint: map['nextRankPoint'] ?? 10000,
      backgroundImage: map['backgroundImage'],
      description: map['description'] ?? txtDefault,
      color: map['color'] ?? colorDefault,
      fee: map['fee'] ?? 0,
    );
  }
}