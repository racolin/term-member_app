import 'package:member_app/presentation/res/strings/values.dart';

class HistoryPointModel {
  final String id;
  final int point;
  final String name;
  final int? targetId;
  final DateTime time;

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
      'time': time.toString(),
    };
  }

  factory HistoryPointModel.fromMap(Map<String, dynamic> map) {
    return HistoryPointModel(
      id: map['id']!,
      point: map['point'] ?? 0,
      name: map['name'] ?? txtUnknown,
      targetId: map['targetId'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] ?? 0),
    );
  }
}