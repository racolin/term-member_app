class CartProductCheckModel {
  final String id;
  final List<String> options;
  final int amount;

  const CartProductCheckModel({
    required this.id,
    required this.options,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'options': options,
      'amount': amount,
    };
  }

  factory CartProductCheckModel.fromMap(Map<String, dynamic> map) {
    return CartProductCheckModel(
      id: map['id']!,
      options: map['options'] ?? [],
      amount: map['amount'] ?? 0,
    );
  }
}