import 'package:member_app/presentation/res/strings/values.dart';

class ProductOptionModel {
  final String id;
  final String name;
  final int minSelected;
  final int maxSelected;
  final List<String> defs;
  final List<ProductOptionItemModel> items;

  const ProductOptionModel({
    required this.id,
    required this.name,
    required this.minSelected,
    required this.maxSelected,
    required this.defs,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'minSelected': minSelected,
      'maxSelected': maxSelected,
      'defs': defs,
      'items': items,
    };
  }

  factory ProductOptionModel.fromMap(Map<String, dynamic> map) {
    return ProductOptionModel(
      id: map['id']!,
      name: map['name'] ?? txtNone,
      minSelected: map['minSelected'] ?? 0,
      maxSelected: map['maxSelected'] ?? 0,
      defs: map['defs'] ?? [],
      items: map['items'] == null
          ? []
          : (map['items'] as List)
              .map((e) => ProductOptionItemModel.fromMap(e))
              .toList(),
    );
  }
}

class ProductOptionItemModel {
  final String id;
  final String name;
  final int cost;
  final bool disable;

  const ProductOptionItemModel({
    required this.id,
    required this.name,
    required this.cost,
    required this.disable,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cost': cost,
      'disable': disable,
    };
  }

  factory ProductOptionItemModel.fromMap(Map<String, dynamic> map) {
    return ProductOptionItemModel(
      id: map['id']!,
      name: map['name'] ?? txtNone,
      cost: map['cost'] ?? 0,
      disable: map['disable'] ?? false,
    );
  }
}
