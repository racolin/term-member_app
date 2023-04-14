import 'package:member_app/presentation/res/strings/values.dart';

class NewsModel {
  final String id;
  final String name;
  List<NewsItemModel> items;

  NewsModel({
    required this.id,
    required this.name,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'items': items.map((e) => e.toMap()),
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id'] as String,
      name: map['name'] as String,
      items: map['items'] as List<NewsItemModel>,
    );
  }
}

class NewsItemModel {
  final String id;
  final String name;
  final String image;
  final DateTime time;
  final String url;

  NewsItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.time,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'time': time.millisecondsSinceEpoch,
      'url': url,
    };
  }

  factory NewsItemModel.fromMap(Map<String, dynamic> map) {
    return NewsItemModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
      image: map['image'],
      time: map['time'] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(map['time']),
      url: map['url'],
    );
  }
}
