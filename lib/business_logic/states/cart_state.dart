import 'package:member_app/data/models/cart_model.dart';

import '../../data/models/cart_detail_model.dart';
import '../../data/models/store_detail_model.dart';
import '../../data/models/voucher_model.dart';
import '../../data/models/store_model.dart';
import '../../presentation/res/strings/values.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final StoreModel? store;
  final StoreDetailModel? storeDetail;
  final String? addressName;
  final String? addressDescription;
  final String? phone;
  final String? receiver;
  final DeliveryType? categoryId;
  final int? payType;
  final VoucherModel? voucher;
  final List<CartProductModel> products;
  final DateTime? time;
  final int fee;
  final int feeDiscount;
  final int voucherDiscount;

  CartLoaded({
    this.store,
    this.storeDetail,
    this.addressName,
    this.addressDescription,
    this.categoryId,
    this.payType,
    this.phone,
    this.receiver,
    this.voucher,
    required this.products,
    this.time,
    this.fee = 0,
    this.voucherDiscount = 0,
    this.feeDiscount = 0,
  });

  int get calculateFee => (fee - feeDiscount) < 0 ? 0 : (fee - feeDiscount);

  int get calculateCost {
    int value = voucherDiscount -
        calculateFee +
        products.fold(
          0,
          (pre, e) => pre + e.cost,
        );
    return value < 0 ? 0 : value;
  }

  CartLoaded copyWith({
    StoreModel? store,
    StoreDetailModel? storeDetail,
    String? addressName,
    String? addressDescription,
    DeliveryType? categoryId,
    int? payType,
    String? phone,
    String? receiver,
    VoucherModel? voucher,
    List<CartProductModel>? products,
    DateTime? time,
    int? fee,
    int? voucherDiscount,
  }) {
    return CartLoaded(
      store: store ?? this.store,
      storeDetail: storeDetail ?? this.storeDetail,
      addressName: addressName ?? this.addressName,
      addressDescription: addressDescription ?? this.addressDescription,
      categoryId: categoryId ?? this.categoryId,
      payType: payType ?? this.payType,
      phone: phone ?? this.phone,
      receiver: receiver ?? this.receiver,
      voucher: voucher ?? this.voucher,
      products: products ?? this.products,
      time: time ?? this.time,
      fee: fee ?? this.fee,
      voucherDiscount: voucherDiscount ?? this.voucherDiscount,
    );
  }
}
