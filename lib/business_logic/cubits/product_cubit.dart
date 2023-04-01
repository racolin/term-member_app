import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/home_state.dart';
import 'package:member_app/business_logic/cubits/product_state.dart';
import 'package:member_app/business_logic/cubits/suggest_product_state.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../data/models/product_short_model.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit()
      : super(
          ProductInitial(),
        );

  void loadProducts({String? storeID}) {
    emit(ProductLoading());
    emit(
      ProductLoaded(
        products: [
          ProductShortModel(
            mainImage:
                'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            id: 'P-1',
          ),
          ProductShortModel(
            mainImage:
                'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            id: 'P-2',
          ),
          ProductShortModel(
            mainImage:
                'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            id: 'P-3',
          ),
          ProductShortModel(
            mainImage:
                'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            id: 'P-4',
          ),
          ProductShortModel(
            mainImage:
                'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            id: 'P-5',
          ),
          ProductShortModel(
            mainImage:
                'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            id: 'P-6',
          ),
        ],
      ),
    );
  }

  void setProduct(HomeBodyType type) async {}
}
