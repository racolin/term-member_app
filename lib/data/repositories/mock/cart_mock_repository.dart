import 'dart:math';

import '../../../business_logic/repositories/cart_repository.dart';
import '../../models/cart_checked_model.dart';
import '../../models/cart_detail_model.dart';
import '../../models/cart_model.dart';
import '../../../exception/app_message.dart';
import '../../models/cart_status_model.dart';
import '../../models/response_model.dart';

class CartMockRepository extends CartRepository {
  @override
  Future<ResponseModel<CartCheckedModel>> checkVoucher({
    required String? storeId,
    required String voucherId,
    required int categoryId,
    required List<CartProductModel> products,
  }) async {
    return ResponseModel<CartCheckedModel>(
      type: ResponseModelType.success,
      data: CartCheckedModel.fromMap({
        "fee": 18000,
        "cost": 100000,
        "voucherDiscount": 25000,
        "products": products
            .map(
              (e) => CartProductModel.fromMap({
                "id": e.id,
                "cost": 35000,
              }),
            )
            .toList(),
      }),
    );
    return ResponseModel<CartCheckedModel>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Có lỗi!',
        content: 'Gặp sự cố khi kiểm tra mã khuyến mãi!',
      ),
    );
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
    return ResponseModel<String>(
      type: ResponseModelType.success,
      data: 'CART-11',
      // data: false,
    );
    return ResponseModel<String>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Có lỗi!',
        content: 'Gặp sự cố khi tạo đơn hàng',
      ),
    );
  }

  @override
  Future<ResponseModel<CartDetailModel>> getDetailById({
    required String id,
  }) async {
    return ResponseModel<CartDetailModel>(
      type: ResponseModelType.success,
      data: CartDetailModel(
        id: id,
        name: 'Đường Đen Marble Latte, Hi-Tea Yuzu Trần Châu +2 sản phẩm khác',
        categoryId: DeliveryType.delivery,
        cost: 114000,
        time: DateTime(2023, 4, 11, 14, 14, 56),
        code: 'TCHL5KHF6GF',
        statusId: 'STT-01',
        fee: 0,
        originalFee: 18000,
        payType: 0,
        phone: '0868754872',
        status: 'done',
        receiver: 'Phan Trung Tín',
        voucherId: 'VOUCHER-01',
        voucherDiscount: 114000,
        voucherName: 'Giảm 50% + FREESHIP đơn 4 ly',
        addressName: '125/42/14 Bùi Đình Tuý, Bình Thạnh, TP.HCM',
        products: [
          CartProductModel.fromMap({
            "id": 'PD-01',
            "name": 'Đường Đen Marble Latte',
            "options": ['Vừa, Nhiều đường'],
            "cost": 55000,
            "amount": 1,
            "note": 'Nhỏ',
          }),
          CartProductModel.fromMap({
            "id": 'PD-02',
            "name": 'Hi-Tea Yuzu Trân Châu',
            "options": ['Vừa, Nhiều đường'],
            "cost": 59000,
            "amount": 1,
            "note": 'Vừa',
          }),
          CartProductModel.fromMap({
            "id": 'PD-03',
            "name": 'Hi-Tea Đào',
            "options": ['Vừa, Nhiều đường'],
            "cost": 59000,
            "amount": 1,
            "note": 'Vừa',
          }),
          CartProductModel.fromMap({
            "id": 'PD-04',
            "name": 'Trà Đen Macchiato',
            "options": ['Vừa, Nhiều đường'],
            "cost": 55000,
            "amount": 1,
            "note": 'Vừa',
          }),
        ],
        point: 56,
      ),
    );
    return ResponseModel<CartDetailModel>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi lấy chi tiết đơn hàng',
      ),
    );
  }

  @override
  Future<ResponseModel<List<CartStatusModel>>> getStatuses() async {
    return ResponseModel<List<CartStatusModel>>(
      type: ResponseModelType.success,
      data: [
        const CartStatusModel(id: 'STT-01', name: 'Đang thực hiện'),
        const CartStatusModel(id: 'STT-02', name: 'Đã hoàn tất'),
        const CartStatusModel(id: 'STT-03', name: 'Đã huỷ'),
      ],
      // data: false,
    );
    return ResponseModel<List<CartStatusModel>>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Có lỗi!',
        content: 'Gặp sự cố khi lấy danh sách trạng thái đơn hàng',
      ),
    );
  }

  @override
  Future<ResponseModel<MapEntry<int, List<CartModel>>>> getsByStatusId({
    required String statusId,
    int? page,
    int? limit,
  }) async {
    return ResponseModel<MapEntry<int, List<CartModel>>>(
      type: ResponseModelType.success,
      data: statusId == 'STT-01' ? const MapEntry(0, []) : MapEntry(
        43,
        List.generate(
          20,
              (index) => CartModel(
            id: 'CART-01',
            name:
            'Đường Đen Marble Latte, Hi-Tea Yuzu Trần Châu +2 sản phẩm khác',
            categoryId: DeliveryType.values[Random().nextInt(3)],
            cost: 114000,
            time: DateTime(2023, 4, 11, 14, 14, 56),
            rate: Random().nextInt(5),
          ),
        ),
      ),
      // data: false,
    );
    return ResponseModel<MapEntry<int, List<CartModel>>>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Có lỗi!',
        content: 'Gặp sự cố khi lấy danh sách đơn hàng theo trạng thái',
      ),
    );
  }

  @override
  Future<ResponseModel<bool>> review({
    required String id,
    required int rate,
    String? review,
  }) async {
    return ResponseModel<bool>(
      type: ResponseModelType.success,
      data: Random(1000).nextBool(),
      // data: false,
    );
    return ResponseModel<bool>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Có lỗi!',
        content: 'Gặp sự cố khi đánh giá đơn hàng',
      ),
    );
  }
}
