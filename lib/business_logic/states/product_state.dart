import 'package:flutter/foundation.dart';
import 'package:member_app/data/models/cart_template_model.dart';

import '../../data/models/product_category_model.dart';
import '../../data/models/product_option_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/product_model.dart';
import '../../exception/app_message.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {
  ProductInitial() {
    // printruntimeType);
  }
}

class ProductLoading extends ProductState {
  ProductLoading() {
    // printruntimeType);
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
    // printruntimeType);
  }

  ProductModel? getProductById(String id) {
    int index = _list.indexWhere((e) => e.id == id);
    if (index == -1) {
      return null;
    }
    return _list[index];
  }

  ProductOptionItemModel? getProductOptionItemById(String productId, String id) {
    var lOps = _list.firstWhere((e) => e.id == productId).optionIds;
    var list = _listOption.where((e) => lOps.contains(e.id));
    for (var i in list) {
      int index = i.optionItems.indexWhere((e) => e.id == id);
      if (index != -1) {
        return i.optionItems[index];
      }
    }
    return null;
  }

  int getCostOptionsItem(String productId, List<String> items) {
    var lOps = _list.firstWhere((e) => e.id == productId).optionIds;
    var list = _listOption.where((e) => lOps.contains(e.id));
    int cost = 0;
    for (var i in list) {
      cost += i.optionItems.fold(0, (pre, e) => pre + (items.contains(e.id) ? e.cost: 0));
    }
    return cost;
  }

  ProductOptionModel? getProductOptionById(String id) {
    int index = listOption.indexWhere((e) => e.id == id);
    if (index != -1) {
      return listOption[index];
    }
    return null;
  }

  List<ProductModel> get list => _list
      .where(
        (e) => !_unavailable.contains(e.id),
      )
      .toList();

  List<ProductModel> get suggestion {
    return list.where((e) => _suggestion.contains(e.id)).toList();
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

    var index = listType.indexWhere((e) => e.id == categoryId);

    if (index == -1) {
      return [];
    }

    return list
        .where(
          (e) => listType[index].productIds.contains(e.id),
        )
        .toList();
  }

  List<ProductModel> getFavorites() {
    return list.where((e) => _favorites.contains(e.id)).toList();
  }

  List<String> get favorites => _favorites;

  bool checkFavorite(String id) {
    return _favorites.any((element) => element == id);
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
    // printruntimeType);
  }
}
