import 'package:member_app/data/models/cart_model.dart';
import 'package:member_app/presentation/res/strings/values.dart';

class CartDetailModel extends CartModel {
  final String code;
  final String statusId;
  final int fee;
  final int originalFee;
  final int payType;
  final String status;
  final String phone;
  final String receiver;
  final String? voucherId;
  final int voucherDiscount;
  final String? voucherName;
  final String addressName;
  final List<CartProductModel> products;
  final CartReviewModel? review;
  final int? point;

  int get total => products.fold(0, (pre, e) => pre + e.cost);

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
    required this.originalFee,
    required this.payType,
    required this.phone,
    required this.status,
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
      'categoryId': categoryId.index,
      'cost': cost,
      'time': time.millisecondsSinceEpoch,
      'rate': rate,
      'code': code,
      'statusId': statusId,
      'fee': fee,
      'originalFee': originalFee,
      'payType': payType,
      'phone': phone,
      'status': status,
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
    CartReviewModel? review;
    if (map['review'] != null && (map['review']! as Map).isNotEmpty) {
      review = CartReviewModel.fromMap(
        map['review'],
      );
    }
    return CartDetailModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
      categoryId: DeliveryType.values[map['categoryId']!],
      cost: map['cost'] ?? 0,
      time: map['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['time'])
          : DateTime.now(),
      rate: map['rate'],
      code: map['code'] as String,
      statusId: map['statusId'] ?? txtUnknown,
      fee: map['fee'] as int,
      originalFee: map['originalFee'] ?? 18000,
      payType: map['payType'] as int,
      phone: map['phone'] as String,
      status: map['status'] as String,
      receiver: map['receiver'] as String,
      voucherId: map['voucherId'],
      voucherDiscount: map['voucherDiscount'] ?? 0,
      voucherName: map['voucherName'],
      addressName: map['addressName'] as String,
      products: map['products'] == null
          ? []
          : (map['products']! as List)
              .map((e) => CartProductModel.fromMap(e))
              .toList(),
      review: review,
      point: map['point'] as int,
    );
  }

  @override
  CartDetailModel copyWith({
    String? id,
    String? name,
    DeliveryType? categoryId,
    int? cost,
    DateTime? time,
    int? rate,
    String? code,
    String? statusId,
    int? fee,
    int? originalFee,
    int? payType,
    String? status,
    String? phone,
    String? receiver,
    String? voucherId,
    int? voucherDiscount,
    String? voucherName,
    String? addressName,
    List<CartProductModel>? products,
    CartReviewModel? review,
    int? point,
  }) {
    return CartDetailModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      cost: cost ?? this.cost,
      name: name ?? this.name,
      time: time ?? this.time,
      rate: rate ?? this.rate,
      code: code ?? this.code,
      statusId: statusId ?? this.statusId,
      fee: fee ?? this.fee,
      originalFee: originalFee ?? this.originalFee,
      payType: payType ?? this.payType,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      receiver: receiver ?? this.receiver,
      voucherId: voucherId ?? this.voucherId,
      voucherDiscount: voucherDiscount ?? this.voucherDiscount,
      voucherName: voucherName ?? this.voucherName,
      addressName: addressName ?? this.addressName,
      products: products ?? this.products,
      review: review ?? this.review,
      point: point ?? this.point,
    );
  }
}

class CartProductModel {
  final String id;
  final String name;
  final int cost;
  final List<String> options;
  final int amount;
  final String note;

  const CartProductModel({
    required this.id,
    required this.name,
    required this.cost,
    required this.options,
    required this.amount,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cost': cost,
      'options': options,
      'amount': amount,
      'note': note,
    };
  }

  Map<String, dynamic> toMapCheck() {
    return {
      'id': id,
      'options': options,
      'amount': amount,
      'note': note,
    };
  }

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
      cost: map['cost'] ?? 0,
      options: (map['options'] is List)
          ? (map['options'] as List).map<String>((e) => e as String).toList()
          : <String>[],
      amount: map['amount'] ?? 0,
      note: map['note'] ?? txtNone,
    );
  }

  CartProductModel copyWith({
    String? id,
    String? name,
    int? cost,
    List<String>? options,
    int? amount,
    String? note,
  }) {
    return CartProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      cost: cost ?? this.cost,
      options: options ?? this.options,
      amount: amount ?? this.amount,
      note: note ?? this.note,
    );
  }

  @override
  bool operator ==(Object? other) {
    if (other is! CartProductModel) {
      return false;
    }

    if (other.id == id &&
        other.note == note &&
        other.options.length == options.length) {
      for (var e in other.options) {
        if (!options.contains(e)) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(id, options);
}

class CartReviewModel {
  final int rate;
  final String? review;

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
