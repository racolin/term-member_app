import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/category_product_state.dart';
import 'package:member_app/data/models/product_category_model.dart';

import 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  CategoryProductCubit() : super(CategoryProductInitial());

  void loadCategories({String? storeID}) {
    emit(CategoryProductLoading());
    // emit(CardWithoutData());
    emit(
      CategoryProductLoaded(
        categories: [
          ProductCategoryModel(
            id: 'CGR-1',
            name: 'Cà Phê',
            image: 'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            slug: 'slug',
            productIDs: ['P-1','P-2','P-3','P-4','P-5','P-6',],
          ),
          ProductCategoryModel(
            id: 'CGR-2',
            name: 'CloudFee',
            image: 'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            slug: 'slug',
            productIDs: ['P-1','P-2','P-3','P-4','P-5','P-6',],
          ),
          ProductCategoryModel(
            id: 'CGR-3',
            name: 'CloudTea',
            image: 'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            slug: 'slug',
            productIDs: ['P-1','P-2','P-3','P-4','P-5','P-6',],
          ),
          ProductCategoryModel(
            id: 'CGR-4',
            name: 'Hi-Tea Healthy',
            image: 'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            slug: 'slug',
            productIDs: ['P-1','P-2','P-3','P-4','P-5','P-6',],
          ),
          ProductCategoryModel(
            id: 'CGR-5',
            name: 'Trà Trái Cây - Trà Sữa',
            image: 'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            slug: 'slug',
            productIDs: ['P-1','P-2','P-3','P-4','P-5','P-6',],
          ),
          ProductCategoryModel(
            id: 'CGR-6',
            name: 'Bánh & Snack',
            image: 'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            slug: 'slug',
            productIDs: ['P-1','P-2','P-3','P-4','P-5','P-6',],
          ),
          ProductCategoryModel(
            id: 'CGR-7',
            name: 'Thưởng thức tại nhà',
            image: 'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            slug: 'slug',
            productIDs: ['P-1','P-2','P-3','P-4','P-5','P-6',],
          ),
          ProductCategoryModel(
            id: 'CGR-8',
            name: 'Thức uống khác',
            image: 'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            slug: 'slug',
            productIDs: ['P-1','P-2','P-3','P-4','P-5','P-6',],
          ),
        ],
      ),
    );
  }
}
