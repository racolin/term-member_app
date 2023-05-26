import '../../../business_logic/repositories/cart_repository.dart';
import '../../../data/models/cart_detail_model.dart';
import '../../../data/models/cart_model.dart';
import '../../models/cart_checked_model.dart';
import '../../models/cart_status_model.dart';
import '../../models/response_model.dart';

class CartStorageRepository extends CartRepository {
  @override
  Future<ResponseModel<CartCheckedModel>> checkVoucher({
    required String? storeId,
    required String voucherId,
    required int categoryId,
    required List<CartProductModel> products,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<String>> create({
    required String? storeId,
    required int categoryId,
    required int payType,
    required String phone,
    required String receiver,
    required int receivingTime,
    String? voucherId,
    String? addressName,
    required List<CartProductModel> products,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<CartDetailModel>> getDetailById({
    required String id,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<CartStatusModel>>> getStatuses() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<MapEntry<int, List<CartModel>>>> getsByStatusId({
    required String statusId,
    int? page,
    int? limit,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> review({
    required String id,
    required int rate,
    String? review,
  }) async {
    throw UnimplementedError();
  }
}
