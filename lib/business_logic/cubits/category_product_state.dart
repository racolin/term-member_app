import 'package:member_app/data/models/category_model.dart';

abstract class CategoryProductState {}

class CategoryProductInitial extends CategoryProductState {}

class CategoryProductLoading extends CategoryProductState {}

class CategoryProductLoaded extends CategoryProductState {
  final List<CategoryModel> categories;

  CategoryProductLoaded({
    required this.categories,
  });
}
