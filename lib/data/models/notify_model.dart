import 'package:member_app/presentation/res/strings/values.dart';

class NotifyModel {
  final String id;
  final String name;
  final String content;
  final String description;
  final String image;
  final DateTime time;
  final String? targetId;
  final bool checked;
  final int? type;

  const NotifyModel({
    required this.id,
    required this.name,
    required this.content,
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
      'description': content,
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
      content: map['content'] ?? '<p>Pilates là phương pháp tập luyện kết hợp một chuỗi các bài tập thể dục có kiểm soát trên các thiết bị chuyên dụng như Reformer, Wunda Chair, Ladder Barrel,… giúp duy trì vóc dáng cân đối, làm săn chắc cơ bắp và tăng cường sức khỏe cho người tập. Ban đầu, Pilates được thiết kế dành riêng cho các cựu chiến binh. Với những bài tập chuyên dụng, Pilates giúp họ hồi phục sức khỏe và tinh thần sau Chiến tranh Thế Giới.</p>'
          '<p>Ngày nay, bộ môn Pilates với nhiều lợi ích về sức khoẻ và thẩm mỹ đã được ứng dụng rộng rãi hơn. Nhiều người nổi tiếng đã theo đuổi phương pháp tập luyện này để giải tỏa tinh thần cũng như giảm cân, giữ dáng.</p>',
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
    String? content,
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
      content: content ?? this.content,
      description: description ?? this.description,
      image: image ?? this.image,
      time: time ?? this.time,
      targetId: targetId ?? this.targetId,
      checked: checked ?? this.checked,
      type: type ?? this.type,
    );
  }
}
