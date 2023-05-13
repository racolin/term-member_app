import 'package:flutter/foundation.dart';

import '../../data/models/product_category_model.dart';
import '../../data/models/product_option_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/product_model.dart';
import '../../exception/app_message.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {
  ProductInitial() {
    print(runtimeType);
  }
}

class ProductLoading extends ProductState {
  ProductLoading() {
    print(runtimeType);
  }
}

class ProductLoaded extends ProductState {
  final List<ProductModel> _list;
  final List<String> _suggestion;
  final List<ProductCategoryModel> _listType;
  final List<ProductOptionModel> _listOption;
  final List<String> _unavailable;
  final List<String> _unavailableOptions;
  final List<String> _unavailableTypes;
  final List<String> _favorites;

  ProductLoaded({
    List<ProductModel>? list,
    List<String>? suggestion = const [],
    List<ProductCategoryModel>? listType,
    List<ProductOptionModel>? listOption,
    List<String>? unavailable,
    List<String>? unavailableOptions,
    List<String>? unavailableTypes,
    List<String>? favorites,
  })  : _list = list ?? [],
        _suggestion = suggestion ?? [],
        _listType = listType ?? [],
        _listOption = listOption ?? [],
        _unavailable = unavailable ?? [],
        _unavailableOptions = unavailableOptions ?? [],
        _unavailableTypes = unavailableTypes ?? [],
        _favorites = favorites ?? [] {
    print(runtimeType);
  }

  List<ProductModel> get list => _list
      .where(
        (e) => !_unavailable.contains(e.id),
      )
      .toList();

  List<ProductModel> get suggestion {
   return _list.where((e) => _suggestion.contains(e.id)).toList();
  }

  List<ProductOptionModel> get listOption => _listOption
      .where(
        (e) => !_unavailableOptions.contains(e.id),
      )
      .toList();

  List<ProductCategoryModel> get listType => _listType
      .where(
        (e) => !_unavailableTypes.contains(e.id),
      )
      .toList();

  List<ProductModel> getSearch(String? key) {
    return list.where((e) => e.name.contains(key ?? '')).toList();
  }

  List<ProductModel> getProductsByCategoryId(String categoryId) {
    if (_unavailableTypes.contains(categoryId)) {
      return [];
    }

    var index = _listType.indexWhere((e) => e.id == categoryId);

    if (index == -1) {
      return [];
    }

    return _list
        .where(
          (e) =>
              !_unavailable.contains(e.id) &&
              _listType[index].productIds.contains(e.id),
        )
        .toList();
  }

  List<ProductModel> getFavorites() {
    return _list.where((e) => _favorites.contains(e.id)).toList();
  }

  ProductLoaded copyWith({
    List<ProductModel>? list,
    List<String>? suggestion,
    List<ProductCategoryModel>? listType,
    List<ProductOptionModel>? listOption,
    List<String>? unavailableList,
    List<String>? unavailableListType,
    List<String>? unavailableListOption,
    List<String>? favorites,
  }) {
    return ProductLoaded(
      list: list ?? _list,
      favorites: favorites ?? _favorites,
      suggestion: suggestion ?? _suggestion,
      listType: listType ?? _listType,
      listOption: listOption ?? _listOption,
      unavailable: unavailableList ?? _unavailable,
      unavailableTypes: unavailableListType ?? _unavailableTypes,
      unavailableOptions: unavailableListOption ?? _unavailableOptions,
    );
  }
}

class ProductFailure extends ProductState {
  final AppMessage message;

  ProductFailure({required this.message}) {
    print(runtimeType);
  }
}
