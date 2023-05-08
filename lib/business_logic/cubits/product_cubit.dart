import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/product_model.dart';

import '../../business_logic/repositories/product_repository.dart';
import '../../business_logic/states/product_state.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';
import '../../presentation/res/strings/values.dart';
import '../blocs/interval/interval_submit.dart';

class ProductCubit extends Cubit<ProductState>
    implements IntervalSubmit<ProductModel> {
  final ProductRepository _repository;

  ProductCubit({
    required ProductRepository repository,
  })  : _repository = repository,
        super(ProductInitial()) {
    emit(ProductLoading());
    _repository.gets().then((res) {
      if (res.type == AppMessageType.success) {
        var list = res.data;
        if (state is ProductLoaded) {
          emit((state as ProductLoaded).copyWith(list: list));
        } else {
          emit(ProductLoaded(
            list: list,
          ));
        }
      } else {
        emit(ProductLoaded(
          list: const [],
        ));
      }
    });
    _repository.getsSuggestion().then((res) {
      if (res.type == AppMessageType.success) {
        var list = res.data;
        if (state is ProductLoaded) {
          emit((state as ProductLoaded).copyWith(suggestion: list));
        } else {
          emit(ProductLoaded(
            suggestion: list,
          ));
        }
      } else {}
    });
    _repository.getCategories().then((res) {
      if (res.type == AppMessageType.success) {
        var listType = res.data;

        if (state is ProductLoaded) {
          emit((state as ProductLoaded).copyWith(listType: listType));
        } else {
          emit(ProductLoaded(
            listType: listType,
          ));
        }
      } else {}
    });
    _repository.getOptions().then((res) {
      if (res.type == AppMessageType.success) {
        var listOption = res.data;
        if (state is ProductLoaded) {
          emit((state as ProductLoaded).copyWith(listOption: listOption));
        } else {
          emit(ProductLoaded(
            listOption: listOption,
          ));
        }
      } else {}
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  Future<AppMessage?> reloadData() async {
    try {
      var resList = await _repository.gets();
      var resListOption = await _repository.getOptions();
      var resListType = await _repository.getCategories();
      if (resList.type == AppMessageType.success) {
        var listOption = resListOption.type == AppMessageType.success
            ? resListOption.data
            : null;
        var listType = resListType.type == AppMessageType.success
            ? resListType.data
            : null;
        emit(ProductLoaded(
          list: resList.data,
          listOption: listOption,
          listType: listType,
        ));
      } else {}
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<AppMessage?> loadFavorites() async {
    if (state is! ProductLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var res = await _repository.getFavorites();
    if (res.type == AppMessageType.success) {
      var list = res.data;
      emit((state as ProductLoaded).copyWith(favorites: list));
      return null;
    } else {
      return res.message;
    }
  }

  AppMessage? setUnavailable({
    required List<String> products,
    required List<String> categories,
    required List<String> options,
  }) {
    if (state is! ProductLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    emit(
      (state as ProductLoaded).copyWith(
        unavailableList: products,
        unavailableListOption: options,
        unavailableListType: categories,
      ),
    );
    return null;
  }

  @override
  Future<List<ProductModel>> submit([String? key]) async {
    if (state is ProductLoaded) {
      return (state as ProductLoaded).getSearch(key);
    }
    return <ProductModel>[];
  }
}
