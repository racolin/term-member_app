import '../../data/models/cart_detail_model.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/cart_status_model.dart';
import '../../data/models/response_model.dart';

abstract class CartRepository {
  Future<ResponseModel<MapEntry<int, List<CartModel>>>> getsByStatusId({
    required String statusId,
    int? page,
    int? limit,
  });

  Future<ResponseModel<CartDetailModel>> getDetailById({
    required String id,
  });

  Future<ResponseModel<List<CartStatusModel>>> getStatuses();

  Future<bool?> review({
    required int rate,
    String? review,
  });

  Future<ResponseModel<CartDetailModel>> checkVoucher({
    required String voucherId,
    required int categoryId,
    required List<CartProductModel> products,
  });

  Future<ResponseModel<String>> create({
    required int categoryId,
    required int payType,
    required String phone,
    required String receiver,
    String? voucherId,
    required String addressName,
    required List<CartProductModel> products,
  });
}
