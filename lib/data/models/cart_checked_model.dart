class CartCheckedModel {
  final int fee;
  final int cost;
  final int voucherDiscount;
  final List<CartProductCheckedModel> products;

  const CartCheckedModel({
    required this.fee,
    required this.cost,
    required this.voucherDiscount,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'fee': fee,
      'cost': cost,
      'voucherDiscount': voucherDiscount,
      'products': products.map((e) => e.toMap()),
    };
  }

  factory CartCheckedModel.fromMap(Map<String, dynamic> map) {
    return CartCheckedModel(
      fee: map['fee'] ?? 0,
      cost: map['cost'] ?? 0,
      voucherDiscount: map['voucherDiscount'] ?? 0,
      products: map['products'] == null
          ? []
          : (map['products']! as List)
          .map((e) => CartProductCheckedModel.fromMap(e))
          .toList(),
    );
  }
}

class CartProductCheckedModel {
  final String id;
  final int cost;

  const CartProductCheckedModel({
    required this.id,
    required this.cost,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cost': cost,
    };
  }

  factory CartProductCheckedModel.fromMap(Map<String, dynamic> map) {
    return CartProductCheckedModel(
      id: map['id']!,
      cost: map['cost'] ?? 0,
    );
  }
}