import '../../data/models/news_model.dart';
import '../../data/models/response_model.dart';

abstract class NewsRepository {
  Future<ResponseModel<List<NewsModel>>> gets();
}
