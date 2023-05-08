import 'package:member_app/data/models/response_model.dart';

import '../../../business_logic/repositories/news_repository.dart';
import '../../../data/models/news_model.dart';

class NewsStorageRepository extends NewsRepository {
  @override
  Future<ResponseModel<List<NewsModel>>> gets() async {
    throw UnimplementedError();
  }
}
