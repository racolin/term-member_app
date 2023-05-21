import 'package:member_app/data/models/cart_detail_model.dart';

class CartTemplateModel {
  final String id;
  final String name;
  final int index;
  final List<CartTemplateProductModel> products;

  const CartTemplateModel({
    required this.id,
    required this.name,
    required this.index,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'index': index,
      'products': products.map((e) => e.toMap()),
    };
  }

  factory CartTemplateModel.fromMap(Map<String, dynamic> map) {
    return CartTemplateModel(
      id: map['id'] as String,
      name: map['name'] as String,
      index: map['index'] as int,
      products: map['products'] == null
          ? []
          : (map['products'] as List)
              .map((e) => CartTemplateProductModel.fromMap(e))
              .toList(),
    );
  }

  String getCode() {
    return products
        .map((e) => '${e.id}|${e.amount}|${e.options.join(',')}')
        .join(' ');
  }

  CartTemplateModel copyWith({
    String? id,
    String? name,
    int? index,
    List<CartTemplateProductModel>? products,
  }) {
    return CartTemplateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      index: index ?? this.index,
      products: products ?? this.products,
    );
  }
}

class CartTemplateProductModel {
  final String id;
  final int amount;
  final List<String> options;

  const CartTemplateProductModel({
    required this.id,
    required this.amount,
    required this.options,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'options': options,
    };
  }

  factory CartTemplateProductModel.fromMap(Map<String, dynamic> map) {
    return CartTemplateProductModel(
      id: map['id']!,
      amount: map['amount']!,
      options: (map['options'] is List)
          ? (map['options'] as List).map<String>((e) => e as String).toList()
          : <String>[],
    );
  }
}
