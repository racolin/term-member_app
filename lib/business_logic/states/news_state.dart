import 'package:flutter/foundation.dart';
import 'package:member_app/exception/app_message.dart';

import '../../data/models/news_model.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> list;
  final int index;

  NewsLoaded({
    required this.list,
    required this.index,
  });

  List<NewsItemModel> getsAll() {
    return list.fold(<NewsItemModel>[], (pre, e) => pre += e.news).toList();
  }

  List<NewsItemModel> get() {
    return [...list[index].news];
  }

  NewsLoaded copyWith({
    List<NewsModel>? list,
    int? index,
  }) {
    return NewsLoaded(
      list: list ?? this.list,
      index: index ?? this.index,
    );
  }
}

class NewsFailure extends NewsState {
  final AppMessage message;
  NewsFailure({required this.message}) {
    // printruntimeType);
  }
}