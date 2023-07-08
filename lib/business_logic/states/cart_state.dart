import 'package:member_app/data/models/cart_model.dart';
import 'package:member_app/data/models/product_model.dart';
import 'package:member_app/exception/app_message.dart';

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
  final int originalFee;
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
    this.originalFee = 0,
  });


  int get calculateCost {
    int value = - voucherDiscount +
        fee +
        products.fold(
          0,
          (pre, e)  {
            print(pre);

            print(e.toMap());
            return pre + e.amount * e.cost;
          },
        );
    print(fee);
    print(voucherDiscount);
    var x = products.fold(
      0,
          (pre, e) {
        print(pre);

        print(e.toMap());
        return pre + e.amount * e.cost;
          },
    );
    print(x);

    return value < 0 ? 0 : value;
  }

  int get amount => products.fold(0, (pre, e) => pre + e.amount);

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
    int? originalFee,
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
      originalFee: originalFee ?? this.originalFee,
      voucherDiscount: voucherDiscount ?? this.voucherDiscount,
    );
  }

  CartLoaded clearVoucher() {
    return CartLoaded(
      store: store,
      storeDetail: storeDetail,
      addressName: addressName,
      addressDescription: addressDescription,
      categoryId: categoryId,
      payType: payType,
      phone: phone,
      receiver: receiver,
      voucher: null,
      products: products,
      time: time,
      fee: originalFee,
      originalFee: originalFee,
      voucherDiscount: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'store': store?.toMap(),
      'storeDetail': storeDetail?.toMap(),
      'addressName': addressName,
      'addressDescription': addressDescription,
      'phone': phone,
      'receiver': receiver,
      'categoryId': categoryId?.index,
      'payType': payType,
      'voucher': voucher?.toMap(),
      'products': products.map((e) => e.toMap()),
      'time': time.toString(),
      'fee': fee,
      'originalFee': originalFee,
      'voucherDiscount': voucherDiscount,
    };
  }

  factory CartLoaded.fromMap(Map<String, dynamic> map) {
    return CartLoaded(
      store: map['store'] == null ? null : StoreModel.fromMap(map['store']),
      storeDetail: map['storeDetail'] == null
          ? null
          : StoreDetailModel.fromMap(map['storeDetail']),
      addressName: map['addressName'],
      addressDescription: map['addressDescription'],
      phone: map['phone'],
      receiver: map['receiver'],
      categoryId: map['categoryId'] == null
          ? null
          : DeliveryType.values[map['categoryId']],
      payType: map['payType'],
      voucher:
          map['voucher'] == null ? null : VoucherModel.fromMap(map['voucher']),
      products: map['products'] == null
          ? []
          : (map['products'] as List)
              .map((e) => CartProductModel.fromMap(e))
              .toList(),
      time: DateTime.tryParse(map['time'] ?? ''),
      fee: map['fee'] ?? 0,
      originalFee: map['originalFee'] ?? 0,
      voucherDiscount: map['voucherDiscount'] ?? 0,
    );
  }
}

class CartFailure extends CartState {
  final AppMessage message;

  CartFailure({
    required this.message,
  });
}
