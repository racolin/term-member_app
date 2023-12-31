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
  final DeliveryType? categoryId;
  final int? payType;
  final String? phone;
  final String? receiver;
  final VoucherModel? voucher;
  final DateTime? receivingTime;
  final String? addressName;
  final String? distanceString;
  final double? addressLat;
  final double? addressLng;
  final List<CartProductModel> products;

  final int fee;
  final int originalFee;
  final int voucherDiscount;

  CartLoaded({
    this.store,
    this.storeDetail,
    this.addressName,
    this.categoryId,
    this.payType,
    this.phone,
    this.receiver,
    this.voucher,
    this.addressLat,
    this.addressLng,
    this.distanceString,
    required this.products,
    this.receivingTime,
    this.fee = 0,
    this.voucherDiscount = 0,
    this.originalFee = 0,
  }) {
    // print('===Cart===');
    // print('store?.toMap()');
    // print(store?.toMap());
    // print('storeDetail?.toMap()');
    // print(storeDetail?.toMap());
    // print('addressName');
    // print(addressName);
    // print('categoryId');
    // print(categoryId);
    // print('payType');
    // print(payType);
    // print('phone');
    // print(phone);
    // print('receiver');
    // print(receiver);
    // print('phone');
    // print(phone);
    // print('voucher');
    // print(voucher?.toMap());
    // print('addressLat');
    // print(addressLat);
    // print('addressLng');
    // print(addressLng);
    // print('fee');
    // print(fee);
    // print('originalFee');
    // print(originalFee);
    // print('voucherDiscount');
    // print(voucherDiscount);
    // print('products');
    // print(products.map((e) => e.toMap()).toList());
    // print('===Cart===');
  }


  int get calculateCost {
    int value = - voucherDiscount +
        (categoryId == DeliveryType.delivery ? fee : 0) +
        products.fold(
          0,
          (pre, e)  {
            print(pre);
            print(e.amount * e.cost);
            print(e.amount);
            print(e.cost);
            print('******');
            return pre + e.cost;
          },
        );

    return value < 0 ? 0 : value;
  }

  int get amount => products.fold(0, (pre, e) => pre + e.amount);

  CartLoaded copyWith({
    StoreModel? store,
    StoreDetailModel? storeDetail,
    String? addressName,
    DeliveryType? categoryId,
    int? payType,
    String? phone,
    String? receiver,
    String? distanceString,
    VoucherModel? voucher,
    List<CartProductModel>? products,
    DateTime? receivingTime,
    double? addressLat,
    double? addressLng,
    int? fee,
    int? originalFee,
    int? voucherDiscount,
  }) {
    return CartLoaded(
      store: store ?? this.store,
      storeDetail: storeDetail ?? this.storeDetail,
      addressName: addressName ?? this.addressName,
      distanceString: distanceString ?? this.distanceString,
      categoryId: categoryId ?? this.categoryId,
      payType: payType ?? this.payType,
      phone: phone ?? this.phone,
      receiver: receiver ?? this.receiver,
      addressLat: addressLat ?? this.addressLat,
      addressLng: addressLng ?? this.addressLng,
      voucher: voucher ?? this.voucher,
      products: products ?? this.products,
      receivingTime: receivingTime ?? this.receivingTime,
      fee: fee ?? this.fee,
      originalFee: originalFee ?? this.originalFee,
      voucherDiscount: voucherDiscount ?? this.voucherDiscount,
    );
  }

  CartLoaded clearVoucher() {
    return copyWith(
      voucherDiscount: 0,
      voucher: null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'store': store?.toMap(),
      'storeDetail': storeDetail?.toMap(),
      'addressName': addressName,
      'distanceString': distanceString,
      'phone': phone,
      'receiver': receiver,
      'addressLat': addressLat,
      'addressLng': addressLng,
      'categoryId': categoryId?.index,
      'payType': payType,
      'voucher': voucher?.toMap(),
      'products': products.map((e) => e.toMap()),
      'time': receivingTime.toString(),
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
      phone: map['phone'],
      distanceString: map['distanceString'],
      receiver: map['receiver'],
      addressLat: map['addressLat'],
      addressLng: map['addressLng'],
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
      receivingTime: DateTime.tryParse(map['time'] ?? ''),
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
