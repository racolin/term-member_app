import 'package:flutter/foundation.dart';

import '../../data/models/news_model.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> listNews;
  final int index;

  NewsLoaded({
    required this.listNews,
    required this.index,
  });

  NewsLoaded copyWith({
    List<NewsModel>? listNews,
    int? index,
  }) {
    return NewsLoaded(
      listNews: listNews ?? this.listNews,
      index: index ?? this.index,
    );
  }
}