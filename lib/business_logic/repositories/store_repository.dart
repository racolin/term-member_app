import '../../data/models/store_detail_model.dart';
import '../../data/models/store_model.dart';

abstract class StoreRepository {
  Future<List<StoreModel>> gets();

  Future<StoreDetailModel?> getDetail({required String id});

  Future<bool?> changeFavorite({
    required String id,
  });
}
