import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/product_model.dart';

import '../../business_logic/repositories/product_repository.dart';
import '../../business_logic/states/product_state.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';
import '../blocs/interval/interval_submit.dart';

class ProductCubit extends Cubit<ProductState>
    implements IntervalSubmit<ProductModel> {
  final ProductRepository _repository;

  ProductCubit({
    required ProductRepository repository,
  })  : _repository = repository,
        super(ProductInitial()) {
    emit(ProductLoading());
    try {
      _repository.gets().then((list) {
        if (state is ProductLoaded) {
          emit((state as ProductLoaded).copyWith(list: list));
        } else {
          emit(ProductLoaded(
            list: list,
          ));
        }
      });
      _repository.getsSuggestion().then((list) {
        if (state is ProductLoaded) {
          emit((state as ProductLoaded).copyWith(suggestion: list));
        } else {
          emit(ProductLoaded(
            suggestion: list,
          ));
        }
      });
      _repository.getCategories().then((listType) {
        if (state is ProductLoaded) {
          emit((state as ProductLoaded).copyWith(listType: listType));
        } else {
          emit(ProductLoaded(
            listType: listType,
          ));
        }
      });
      _repository.getOptions().then((listOption) {
        if (state is ProductLoaded) {
          emit((state as ProductLoaded).copyWith(listOption: listOption));
        } else {
          emit(ProductLoaded(
            listOption: listOption,
          ));
        }
      });
    } on AppException catch (ex) {}
  }

  // base method: return response model, use to avoid repeat code.

  // api method

  // get data method: return model if state is loaded, else return null

  Future<AppMessage?> reloadData() async {
    try {
      var list = await _repository.gets();
      var listOption = await _repository.getOptions();
      var listType = await _repository.getCategories();
      emit(ProductLoaded(
        list: list,
        listOption: listOption,
        listType: listType,
      ));
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<AppMessage?> loadFavorites() async {
    if (state is ProductLoaded) {
      try {
        var list = await _repository.getFavorites();
        emit((state as ProductLoaded).copyWith(favorites: list));
      } on AppException catch (ex) {
        return ex.message;
      }
    } else {
      return AppMessage(
        type: AppMessageType.failure,
        title: 'Hãy đợi',
        content: 'Thao tác của bạn quá nhanh. Hãy thử lại!',
      );
    }
    return null;
  }

  AppMessage? setUnavailable({
    required List<String> products,
    required List<String> categories,
    required List<String> options,
  }) {
    if (state is ProductLoaded) {
      emit(
        (state as ProductLoaded).copyWith(
          unavailableList: products,
          unavailableListOption: options,
          unavailableListType: categories,
        ),
      );
      return null;
    }
    return AppMessage(
      type: AppMessageType.failure,
      title: 'Xảy ra lỗi',
      content: 'Không thể lọc sản sẩm theo cửa hàng.',
    );
  }

  @override
  Future<List<ProductModel>> submit([String? key]) async {
    if (state is ProductLoaded) {
      return (state as ProductLoaded).getSearch(key);
    }
    return <ProductModel>[];
  }
}
