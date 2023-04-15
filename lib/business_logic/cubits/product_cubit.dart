import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/store_cubit.dart';
import 'package:member_app/business_logic/repositories/product_repository.dart';
import 'package:member_app/business_logic/states/product_state.dart';
import 'package:member_app/exception/app_exception.dart';
import 'package:member_app/exception/app_message.dart';

import '../../data/models/product_model.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repository;
  final StoreCubit _storeCubit;
  late StreamSubscription subscription;

  ProductCubit(
      {required ProductRepository repository, required StoreCubit storeCubit,})
      : _repository = repository,
        _storeCubit = storeCubit,
        super(ProductInitial()) {
    subscription = _storeCubit.onChange ((stateB) {
      //here logic based on different children of StateB
    });

    Cubit
    emit(ProductLoading());
    try {
      _repository.gets().then((list) {
        if (state is ProductLoaded) {
          emit((state as ProductLoaded).copyWith(list: list));
        } else {
          emit(ProductLoaded(list: list,));
        }
      });
      _repository.getCategories().then((listType) {
        if (state is ProductLoaded) {
          emit((state as ProductLoaded).copyWith(listType: listType));
        } else {
          emit(ProductLoaded(listType: listType,));
        }
      });
      _repository.getOptions().then((listOption) {
        if (state is ProductLoaded) {
          emit((state as ProductLoaded).copyWith(listOption: listOption));
        } else {
          emit(ProductLoaded(listOption: listOption,));
        }
      });
    } on AppException catch (ex) {
      emit(ProductState)
    }
  }

  ///
  /// Không cần reload lại mỗi khi vào app nếu đã có
  ///
  void reloadProducts({String? storeID}) {
    _repository.
    emit(ProductLoading());
    emit(
      ProductLoaded(
        list: [
          ProductModel(
            image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            id: 'P-1',
          ),
          ProductModel(
            image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            id: 'P-2',
          ),
          ProductModel(
            image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            id: 'P-3',
          ),
          ProductModel(
            image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            id: 'P-4',
          ),
          ProductModel(
            image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            id: 'P-5',
          ),
          ProductModel(
            image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            id: 'P-6',
          ),
        ],
      ),
    );
  }

  AppMessage? setUnavailable({required List<String> products, required List<
      String> categories, required List<String> options,}) {
    if (state is ProductLoaded) {
      emit((state as ProductLoaded).copyWith(unavailableList: products,
        unavailableListOption: options,
        unavailableListType: categories,),);
      return null;
    }
  }
}
