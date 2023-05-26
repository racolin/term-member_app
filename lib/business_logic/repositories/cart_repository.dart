import '../../data/models/cart_checked_model.dart';
import '../../data/models/cart_detail_model.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/cart_status_model.dart';
import '../../data/models/response_model.dart';

abstract class CartRepository {

  ///
  /// Success: data is [ResponseModel<MapEntry<int, List<CartModel>>>], message = null
  ///
  /// - key (int) is maxCount
  ///
  /// - value is List<CartModel>
  ///
  /// Failure: data = null, message != null
  ///
  Future<ResponseModel<MapEntry<int, List<CartModel>>>> getsByStatusId({
    required String statusId,
    int? page,
    int? limit,
  });

  Future<ResponseModel<CartDetailModel>> getDetailById({
    required String id,
  });

  Future<ResponseModel<List<CartStatusModel>>> getStatuses();

  Future<ResponseModel<bool>> review({
    required String id,
    required int rate,
    String? review,
  });

  Future<ResponseModel<CartCheckedModel>> checkVoucher({
    required String? storeId,
    required String voucherId,
    required int categoryId,
    required List<CartProductModel> products,
  });

  Future<ResponseModel<String>> create({
    required String? storeId,
    required int categoryId,
    required int payType,
    required String phone,
    required String receiver,
    required int receivingTime,
    String? voucherId,
    required String addressName,
    required List<CartProductModel> products,
  });
}
