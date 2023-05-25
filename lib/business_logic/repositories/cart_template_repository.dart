import '../../data/models/cart_template_model.dart';
import '../../data/models/response_model.dart';

abstract class CartTemplateRepository {
  Future<ResponseModel<MapEntry<int, List<CartTemplateModel>>>> gets();

  Future<ResponseModel<String>> create({
    required String name,
    required List<CartTemplateProductModel> products,
  });

  Future<ResponseModel<bool>> update({
    required String id,
    required String name,
    required List<CartTemplateProductModel> products,
  });

  Future<ResponseModel<bool>> arrange({
    required List<String> ids,
  });

  Future<ResponseModel<bool>> delete({
    required String id,
  });
}
