import '../../data/models/cart_template_model.dart';

abstract class CartTemplateRepository {
  Future<MapEntry<int, List<CartTemplateModel>>> gets();

  Future<String?> create({
    required String name,
    required List<CartTemplateProductModel> products,
  });

  Future<bool?> edit({
    required String id,
    required String name,
    required List<CartTemplateProductModel> products,
  });

  Future<bool?> arrange({
    required List<String> ids,
  });

  Future<bool?> delete({
    required String id,
  });
}
