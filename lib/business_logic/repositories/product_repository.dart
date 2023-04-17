import 'package:member_app/data/models/product_option_model.dart';

import '../../data/models/product_model.dart';
import '../../data/models/product_category_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> gets();

  Future<List<ProductModel>> getsSuggestion({int limit});

  Future<List<ProductCategoryModel>> getCategories();

  Future<List<ProductOptionModel>> getOptions();

  Future<List<String>> getFavorites();

  Future<bool?> changeFavorite({
    required String id,
  });
}
