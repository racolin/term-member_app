class NewsModel {
  final String title;
  List<NewsItemModel> newsItems;

  NewsModel({
    required this.title,
    required this.newsItems,
  });
}

class NewsItemModel {
  final String title;
  final String image;
  final String dateTime;
  final String link;

  NewsItemModel({
    required this.title,
    required this.image,
    required this.dateTime,
    required this.link,
  });
}
