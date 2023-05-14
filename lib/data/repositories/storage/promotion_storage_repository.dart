import 'package:member_app/data/models/response_model.dart';

import '../../../data/models/promotion_category_model.dart';
import '../../../data/models/promotion_model.dart';
import '../../../business_logic/repositories/promotion_repository.dart';

class PromotionStorageRepository extends PromotionRepository {
  @override
  Future<ResponseModel<List<PromotionCategoryModel>>> getCategories() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<PromotionModel>>> gets() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> exchangePromotion(String id) {
    // TODO: implement exchangePromotion
    throw UnimplementedError();
  }
}
