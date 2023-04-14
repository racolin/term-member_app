import 'package:member_app/data/models/cart_model.dart';
import 'package:member_app/presentation/res/strings/values.dart';

class CartDetailModel extends CartModel {
  final String code;
  final String statusId;
  final int fee;
  final int payType;
  final String phone;
  final String receiver;
  final String voucherId;
  final int voucherDiscount;
  final String voucherName;
  final String addressName;
  final List<CartProductModel> products;
  final CartReviewModel? review;
  final int point;

  const CartDetailModel({
    required super.id,
    required super.name,
    required super.categoryId,
    required super.cost,
    required super.time,
    super.rate,
    required this.code,
    required this.statusId,
    required this.fee,
    required this.payType,
    required this.phone,
    required this.receiver,
    required this.voucherId,
    required this.voucherDiscount,
    required this.voucherName,
    required this.addressName,
    required this.products,
    this.review,
    required this.point,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'cost': cost,
      'time': time.millisecondsSinceEpoch,
      'rate': rate,
      'code': code,
      'statusId': statusId,
      'fee': fee,
      'payType': payType,
      'phone': phone,
      'receiver': receiver,
      'voucherId': voucherId,
      'voucherDiscount': voucherDiscount,
      'voucherName': voucherName,
      'addressName': addressName,
      'products': products.map((e) => e.toMap()),
      'review': review?.toMap(),
      'point': point,
    };
  }

  factory CartDetailModel.fromMap(Map<String, dynamic> map) {
    return CartDetailModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
      categoryId: map['categoryId']!,
      cost: map['cost'] ?? 0,
      time: map['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['time'])
          : DateTime.now(),
      rate: map['rate'],
      code: map['code'] as String,
      statusId: map['statusId'] as String,
      fee: map['fee'] as int,
      payType: map['payType'] as int,
      phone: map['phone'] as String,
      receiver: map['receiver'] as String,
      voucherId: map['voucherId'] as String,
      voucherDiscount: map['voucherDiscount'] ?? 0,
      voucherName: map['voucherName'] as String,
      addressName: map['addressName'] as String,
      products: map['products'] == null
          ? []
          : (map['products']! as List)
              .map((e) => CartProductModel.fromMap(e))
              .toList(),
      review: map['review'] == null
          ? null
          : CartReviewModel.fromMap(
              map['review'],
            ),
      point: map['point'] as int,
    );
  }
}

class CartProductModel {
  final String id;
  final String name;
  final int cost;
  final int amount;
  final String note;

  const CartProductModel({
    required this.id,
    required this.name,
    required this.cost,
    required this.amount,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cost': cost,
      'amount': amount,
      'note': note,
    };
  }

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
      cost: map['cost'] ?? 0,
      amount: map['amount'] ?? 0,
      note: map['note'] ?? txtNone,
    );
  }
}

class CartReviewModel {
  final int rate;
  final String review;

  const CartReviewModel({
    required this.rate,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'review': review,
    };
  }

  factory CartReviewModel.fromMap(Map<String, dynamic> map) {
    return CartReviewModel(
      rate: map['rate'] ?? 0,
      review: map['review'] ?? txtNone,
    );
  }
}

class CartStatusModel {
  final String id;
  final String name;

  const CartStatusModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CartStatusModel.fromMap(Map<String, dynamic> map) {
    return CartStatusModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
    );
  }
}
