import '../../data/models/cart_checked_model.dart';
import '../../data/models/cart_detail_model.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/cart_check_model.dart';

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

  Future<CartCheckedModel?> checkVoucher({
    required String voucherId,
    required int categoryId,
    required List<CartProductCheckModel> products,
  });

  Future<String?> create({
    required int categoryId,
    required int payType,
    required String phone,
    required String receiver,
    String? voucherId,
    String? addressName,
    required List<CartProductCheckModel> products,
  });
}
