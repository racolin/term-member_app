class CartProductCheckModel {
  final String id;
  final List<String> options;
  final int amount;
  final int cost;

  const CartProductCheckModel({
    required this.id,
    required this.options,
    required this.amount,
    required this.cost,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'options': options,
      'amount': amount,
      // 'cost': cost,
    };
  }

  factory CartProductCheckModel.fromMap(Map<String, dynamic> map) {
    return CartProductCheckModel(
      id: map['id']!,
      options: map['options'] ?? [],
      amount: map['amount'] ?? 0,
      cost: map['cost'] ?? 0,
    );
  }

  CartProductCheckModel copyWith({
    String? id,
    List<String>? options,
    int? amount,
    int? cost,
  }) {
    return CartProductCheckModel(
      id: id ?? this.id,
      options: options ?? this.options,
      amount: amount ?? this.amount,
      cost: cost ?? this.cost,
    );
  }
}