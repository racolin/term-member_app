import 'dart:math';

import 'package:dio/dio.dart';

import '../../business_logic/repositories/cart_repository.dart';
import '../../data/models/cart_check_model.dart';
import '../../data/models/cart_checked_model.dart';
import '../../data/models/cart_detail_model.dart';
import '../../data/models/cart_model.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';

class CartApiRepository extends CartRepository {
  @override
  Future<CartCheckedModel?> checkVoucher({
    required String voucherId,
    required int categoryId,
    required List<CartProductCheckModel> products,
  }) async {
    try {
      return CartCheckedModel(
        fee: 18000,
        cost: 100000,
        voucherDiscount: 25000,
        products: products
            .map(
              (e) => CartProductCheckedModel(
                id: e.id,
                cost: 35000,
              ),
            )
            .toList(),
      );
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi kiểm tra Voucher',
        ),
      );
    }
  }

  @override
  Future<String?> create({
    required int categoryId,
    required int payType,
    required String phone,
    required String receiver,
    String? voucherId,
    String? addressName,
    required List<CartProductCheckModel> products,
  }) async {
    try {
      return 'CART-11';
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi tạo Cart',
        ),
      );
    }
  }

  @override
  Future<CartDetailModel?> getDetailById({
    required String id,
  }) async {
    try {
      return CartDetailModel(
        id: id,
        name: 'Đường Đen Marble Latte, Hi-Tea Yuzu Trần Châu +2 sản phẩm khác',
        categoryId: 0,
        cost: 114000,
        time: DateTime(2023, 4, 11, 14, 14, 56),
        code: 'TCHL5KHF6GF',
        statusId: 'STT-01',
        fee: 0,
        payType: 0,
        phone: '0868754872',
        receiver: 'Phan Trung Tín',
        voucherId: 'VOUCHER-01',
        voucherDiscount: 114000,
        voucherName: 'Giảm 50% + FREESHIP đơn 4 ly',
        addressName: '125/42/14 Bùi Đình Tuý, Bình Thạnh, TP.HCM',
        products: [
          const CartProductModel(
            id: 'PD-01',
            name: 'Đường Đen Marble Latte',
            cost: 55000,
            amount: 1,
            note: 'Nhỏ',
          ),
          const CartProductModel(
            id: 'PD-02',
            name: 'Hi-Tea Yuzu Trân Châu',
            cost: 59000,
            amount: 1,
            note: 'Vừa',
          ),
          const CartProductModel(
            id: 'PD-03',
            name: 'Hi-Tea Đào',
            cost: 59000,
            amount: 1,
            note: 'Vừa',
          ),
          const CartProductModel(
            id: 'PD-04',
            name: 'Trà Đen Macchiato',
            cost: 55000,
            amount: 1,
            note: 'Vừa',
          ),
        ],
        point: 56,
      );
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy chi tiết Cart',
        ),
      );
    }
  }

  @override
  Future<List<CartStatusModel>> getStatuses() async {
    try {
      return [
        const CartStatusModel(id: 'STT-01', name: 'Tại quầy'),
        const CartStatusModel(id: 'STT-02', name: 'Đến lấy'),
        const CartStatusModel(id: 'STT-03', name: 'Giao hàng'),
      ];
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy danh sách status',
        ),
      );
    }
    return [];
  }

  @override
  Future<MapEntry<int, List<CartModel>>> getsByStatusId({
    required String statusId,
    int? page,
    int? limit,
  }) async {
    try {
      return MapEntry(
        43,
        List.generate(
          20,
          (index) => CartModel(
            id: 'CART-01',
            name:
                'Đường Đen Marble Latte, Hi-Tea Yuzu Trần Châu +2 sản phẩm khác',
            categoryId: 0,
            cost: 114000,
            time: DateTime(2023, 4, 11, 14, 14, 56),
          ),
        ),
      );
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy danh sách Cart bằng status',
        ),
      );
    }
  }

  @override
  Future<bool?> review({
    required int rate,
    String? review,
  }) async {
    try {
      return Random(1000).nextBool();
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi review Cart',
        ),
      );
    }
  }
}
