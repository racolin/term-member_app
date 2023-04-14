class ProductOptionModel {
  final String id;
  final String name;
  final int maxChoose;
  final bool isForce;
  final List<OptionProductItemModel> items;

  ProductOptionModel({
    required this.id,
    required this.name,
    required this.isForce,
    required this.maxChoose,
    required this.items,
  });
}

class OptionProductItemModel {
  final String id;
  final String name;
  final int cost;

  OptionProductItemModel({
    required this.id,
    required this.name,
    required this.cost,
  });
}