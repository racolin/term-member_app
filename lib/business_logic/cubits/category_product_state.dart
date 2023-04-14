import 'package:member_app/data/models/product_category_model.dart';

abstract class CategoryProductState {}

class CategoryProductInitial extends CategoryProductState {}

class CategoryProductLoading extends CategoryProductState {}

class CategoryProductLoaded extends CategoryProductState {
  final List<ProductCategoryModel> categories;

  CategoryProductLoaded({
    required this.categories,
  });
}
