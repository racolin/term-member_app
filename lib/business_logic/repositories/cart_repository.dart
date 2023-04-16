import '../../data/models/cart_detail_model.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/cart_status_model.dart';

abstract class CartRepository {
  Future<MapEntry<int, List<CartModel>>> getsByStatusId({
    required String statusId,
    int? page,
    int? limit,
  });

  Future<CartDetailModel?> getDetailById({
    required String id,
  });

  Future<List<CartStatusModel>> getStatuses();

  Future<bool?> review({
    required int rate,
    String? review,
  });

  Future<CartDetailModel?> checkVoucher({
    required String voucherId,
    required int categoryId,
    required List<CartProductModel> products,
  });

  Future<String?> create({
    required int categoryId,
    required int payType,
    required String phone,
    required String receiver,
    String? voucherId,
    required String addressName,
    required List<CartProductModel> products,
  });
}
