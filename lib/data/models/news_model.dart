import 'package:member_app/presentation/res/strings/values.dart';

class NewsModel {
  final String id;
  final String name;
  List<NewsItemModel> news;

  NewsModel({
    required this.id,
    required this.name,
    required this.news,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'news': news.map((e) => e.toMap()),
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id'] as String,
      name: map['name'] as String,
      news: (map['news'] is List)
          ? (map['news'] as List)
              .map(
                (e) => NewsItemModel.fromMap(e),
              )
              .toList()
          : <NewsItemModel>[],
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
      time: DateTime.tryParse(map['time'] ?? '') ?? DateTime.now(),
      // map['time'] == null
      //     ? DateTime.now()
      //     : DateTime.fromMillisecondsSinceEpoch(map['time']),
      url: map['url'],
    );
  }
}
