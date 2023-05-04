import '../../data/models/promotion_category_model.dart';
import '../../data/models/promotion_model.dart';
import '../../data/models/response_model.dart';

abstract class PromotionRepository {

  Future<ResponseModel<MapEntry<int, List<PromotionModel>>>> gets();

  Future<ResponseModel<List<PromotionCategoryModel>>> getCategories();
}