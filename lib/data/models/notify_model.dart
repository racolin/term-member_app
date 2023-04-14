import 'package:member_app/presentation/res/strings/values.dart';

class NotifyModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final DateTime time;
  final String? targetId;
  final bool checked;
  final int? type;

  const NotifyModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.time,
    this.targetId,
    required this.checked,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'time': time,
      'targetId': targetId,
      'checked': checked,
      'type': type,
    };
  }

  factory NotifyModel.fromMap(Map<String, dynamic> map) {
    return NotifyModel(
      id: map['id']!,
      name: map['name'] ?? txtNone,
      description: map['description'] ?? txtNone,
      image: map['image'],
      time: map['time'] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(map['time']),
      targetId: map['targetId'],
      checked: map['checked'] ?? false,
      type: map['type'],
    );
  }

  NotifyModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    DateTime? time,
    String? targetId,
    bool? checked,
    int? type,
  }) {
    return NotifyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      time: time ?? this.time,
      targetId: targetId ?? this.targetId,
      checked: checked ?? this.checked,
      type: type ?? this.type,
    );
  }
}
