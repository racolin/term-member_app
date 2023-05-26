import 'package:member_app/data/models/cart_model.dart';
import 'package:member_app/presentation/res/strings/values.dart';

class CartCheckedModel {
  final int fee;
  final int originalFee;
  final int voucherDiscount;
  final List<CartProductCheckedModel> products;
  
  const CartCheckedModel({
    required this.fee,
    required this.originalFee,
    required this.voucherDiscount,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'fee': fee,
      'originalFee': originalFee,
      'voucherDiscount': voucherDiscount,
      'products': products.map((e) => e.toMap()),
    };
  }

  factory CartCheckedModel.fromMap(Map<String, dynamic> map) {
    return CartCheckedModel(
      fee: map['fee'] as int,
      originalFee: map['originalFee'] ?? 18000,
      voucherDiscount: map['voucherDiscount'] ?? 0,
      products: map['products'] == null
          ? []
          : (map['products']! as List)
              .map((e) => CartProductCheckedModel.fromMap(e))
              .toList(),
    );
  }

  CartCheckedModel copyWith({
    int? fee,
    int? originalFee,
    int? voucherDiscount,
    List<CartProductCheckedModel>? products,
  }) {
    return CartCheckedModel(
      fee: fee ?? this.fee,
      originalFee: originalFee ?? this.originalFee,
      voucherDiscount: voucherDiscount ?? this.voucherDiscount,
      products: products ?? this.products,
    );
  }
}

class CartProductCheckedModel {
  final String id;
  final int cost;
  final int discount;

  const CartProductCheckedModel({
    required this.id,
    required this.cost,
    required this.discount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cost': cost,
      'discount': discount,
    };
  }

  factory CartProductCheckedModel.fromMap(Map<String, dynamic> map) {
    return CartProductCheckedModel(
      id: map['id']!,
      cost: map['cost'] ?? 0,
      discount: map['discount'] ?? 0,
    );
  }

  CartProductCheckedModel copyWith({
    String? id,
    int? cost,
    int? discount,
  }) {
    return CartProductCheckedModel(
      id: id ?? this.id,
      cost: cost ?? this.cost,
      discount: discount ?? this.discount,
    );
  }
}
