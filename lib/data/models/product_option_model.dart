import 'package:member_app/presentation/res/strings/values.dart';

class ProductOptionModel {
  final String id;
  final String name;
  final int minSelected;
  final int maxSelected;
  final List<String> defaultSelect;
  final List<ProductOptionItemModel> optionItems;
  
  const ProductOptionModel({
    required this.id,
    required this.name,
    required this.minSelected,
    required this.maxSelected,
    required this.defaultSelect,
    required this.optionItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'minSelected': minSelected,
      'maxSelected': maxSelected,
      'defaultSelect': defaultSelect,
      'optionItems': optionItems,
    };
  }

  factory ProductOptionModel.fromMap(Map<String, dynamic> map) {
    var mi = map['minSelected'] ?? 0;
    var items = map['optionItems'] == null
        ? <ProductOptionItemModel>[]
        : (map['optionItems'] as List)
        .map((e) => ProductOptionItemModel.fromMap(e))
        .toList();
    return ProductOptionModel(
      id: map['id']!,
      name: map['name'] ?? txtNone,
      minSelected: mi,
      maxSelected: map['maxSelected'] ?? 0,
      defaultSelect: (map['defaultSelect'] is List)
          ? (map['defaultSelect'] as List).map<String>((e) => e as String).toList()
          : <String>[],
      optionItems: items,
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
