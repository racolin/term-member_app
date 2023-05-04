import '../../data/models/response_model.dart';
import '../../data/models/store_detail_model.dart';
import '../../data/models/store_model.dart';

abstract class StoreRepository {
  Future<ResponseModel<List<StoreModel>>> gets();

  Future<ResponseModel<StoreDetailModel>> getDetail({required String id});

  Future<ResponseModel<bool>> changeFavorite({
    required String id,
  });
}
