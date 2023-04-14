import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/home_state.dart';
import 'package:member_app/business_logic/cubits/product_state.dart';

import '../../data/models/product_model.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit()
      : super(
          ProductInitial(),
        );

  void loadProducts({String? storeID}) {
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

  void setProduct(HomeBodyType type) async {}
}
