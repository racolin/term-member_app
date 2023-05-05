import 'package:dio/dio.dart';

import '../../../business_logic/repositories/cart_template_repository.dart';
import '../../../data/models/cart_template_model.dart';
import '../../../exception/app_exception.dart';
import '../../../exception/app_message.dart';
import '../../models/response_model.dart';

class CartTemplateStorageRepository extends CartTemplateRepository {

  @override
  Future<ResponseModel<bool>> arrange({
    required List<String> ids,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<String>> create({
    required String name,
    required List<CartTemplateProductModel> products,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> delete({required String id}) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> edit({
    required String id,
    required String name,
    required List<CartTemplateProductModel> products,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<MapEntry<int, List<CartTemplateModel>>>> gets() async {
    throw UnimplementedError();
  }
}
