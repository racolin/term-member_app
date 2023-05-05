import 'package:dio/dio.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../../data/models/product_category_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/product_option_model.dart';
import '../../../business_logic/repositories/product_repository.dart';
import '../../../exception/app_exception.dart';
import '../../../exception/app_message.dart';

class ProductStorageRepository extends ProductRepository {

  @override
  Future<ResponseModel<bool>> changeFavorite({required String id}) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<ProductCategoryModel>>> getCategories() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<String>>> getFavorites() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<ProductOptionModel>>> getOptions() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<ProductModel>>> gets() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<ProductModel>>> getsSuggestion({int limit = 4}) async {
    throw UnimplementedError();
  }
}
