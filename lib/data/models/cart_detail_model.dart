import 'package:member_app/data/models/cart_model.dart';
import 'package:member_app/presentation/res/strings/values.dart';

class CartDetailModel extends CartModel {
  final String code;
  final String statusId;
  final int fee;
  final int originalFee;
  final int payType;
  final bool? isPaid;
  final String status;
  final String phone;
  final String receiver;
  final String? voucherId;
  final int voucherDiscount;
  final String? voucherName;
  final String addressName;
  final List<CartProductModel> products;
  final CartReviewModel? review;
  final CartReviewShipperModel? reviewShipper;
  final int? point;
  final int? reviewPoint;
  final int? reviewShipperPoint;
  final List<CartTimeLog>? timeLog;

  int get total => products.fold(0, (pre, e) => pre + e.cost * e.amount);

  const CartDetailModel({
    required super.id,
    required super.name,
    required super.categoryId,
    required super.cost,
    required super.time,
    this.isPaid,
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
    this.reviewShipper,
    required this.point,
    required this.reviewPoint,
    required this.reviewShipperPoint,
    required this.timeLog,
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
      'isPaid': isPaid,
      'phone': phone,
      'status': status,
      'receiver': receiver,
      'voucherId': voucherId,
      'voucherDiscount': voucherDiscount,
      'voucherName': voucherName,
      'addressName': addressName,
      'products': products.map((e) => e.toMap()),
      'review': review?.toMap(),
      'reviewShipper': reviewShipper?.toMap(),
      'point': point,
      'reviewShipperPoint': reviewShipperPoint,
      'reviewPoint': reviewPoint,
      'timeLog': timeLog?.map((e) => e.toMap())
    };
  }

  factory CartDetailModel.fromMap(Map<String, dynamic> map) {
    CartReviewModel? review;
    if (map['review'] != null && (map['review']! as Map).isNotEmpty) {
      review = CartReviewModel.fromMap(
        map['review'],
      );
    }
    CartReviewShipperModel? reviewShipper;
    if (map['reviewShipper'] != null &&
        (map['reviewShipper']! as Map).isNotEmpty) {
      reviewShipper = CartReviewShipperModel.fromMap(
        map['reviewShipper'],
      );
    }
    List<CartTimeLog>? timeLog;
    if (map['timeLog'] != null && (map['timeLog']! as List).isNotEmpty) {
      timeLog =
          (map['timeLog'] as List).map((e) => CartTimeLog.fromMap(e)).toList();
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
      isPaid: map['isPaid'],
      phone: map['phone'] ?? '',
      status: map['status'] as String,
      receiver: map['receiver'] ?? '',
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
      reviewShipper: reviewShipper,
      reviewPoint: map['reviewPoint'],
      reviewShipperPoint: map['reviewShipperPoint'],
      timeLog: timeLog,
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
    bool? isPaid,
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
    CartReviewShipperModel? reviewShipper,
    List<CartTimeLog>? timeLog,
    int? point,
    int? reviewPoint,
    int? reviewShipperPoint,
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
      isPaid: isPaid ?? this.isPaid,
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
      reviewShipper: reviewShipper ?? this.reviewShipper,
      reviewShipperPoint: reviewShipperPoint ?? this.reviewShipperPoint,
      reviewPoint: reviewPoint ?? this.reviewPoint,
      timeLog: timeLog ?? this.timeLog,
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
  final List<String> likeItems;
  final List<String> dislikeItems;

  const CartReviewModel({
    required this.rate,
    required this.review,
    required this.likeItems,
    required this.dislikeItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'review': review,
      'likeItems': likeItems,
      'dislikeItems': dislikeItems,
    };
  }

  factory CartReviewModel.fromMap(Map<String, dynamic> map) {
    return CartReviewModel(
      rate: map['rate'] ?? 0,
      review: map['review'] ?? txtNone,
      likeItems: map['likeItems'] ?? [],
      dislikeItems: map['dislikeItems'] ?? [],
    );
  }
}

class CartReviewShipperModel {
  final int rate;
  final String? review;

  const CartReviewShipperModel({
    required this.rate,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'review': review,
    };
  }

  factory CartReviewShipperModel.fromMap(Map<String, dynamic> map) {
    return CartReviewShipperModel(
      rate: map['rate'] ?? 0,
      review: map['review'] ?? txtNone,
    );
  }
}

class CartTimeLog {
  final DateTime time;
  final String title;
  final String description;

  const CartTimeLog({
    required this.time,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'time': time.millisecondsSinceEpoch,
      'title': title,
      'description': description,
    };
  }

  factory CartTimeLog.fromMap(Map<String, dynamic> map) {
    return CartTimeLog(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      title: map['title'] as String,
      description: map['description'] ?? '',
    );
  }
}
