import '../../data/models/promotion_category_model.dart';
import '../../data/models/promotion_model.dart';

abstract class PromotionRepository {

  Future<List<PromotionModel>> gets();

  Future<List<PromotionCategoryModel>> getCategories();
}