import 'package:member_app/presentation/res/strings/values.dart';

class HistoryPointModel {
  final String id;
  final int point;
  final String name;
  final String? targetId;
  final String time;

  const HistoryPointModel({
    required this.id,
    required this.point,
    required this.name,
    this.targetId,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'point': point,
      'name': name,
      'targetId': targetId,
      'time': time,
    };
  }

  factory HistoryPointModel.fromMap(Map<String, dynamic> map) {
    return HistoryPointModel(
      id: map['id']!,
      point: map['point'] ?? 0,
      name: map['name'] ?? txtUnknown,
      targetId: map['targetId'],
      time: map['time'] ?? DateTime.now(),
    );
  }
}