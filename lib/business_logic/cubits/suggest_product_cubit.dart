import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/home_state.dart';
import 'package:member_app/business_logic/cubits/suggest_product_state.dart';
import 'package:member_app/data/models/product_model.dart';
import 'package:member_app/presentation/res/strings/values.dart';

class SuggestProductCubit extends Cubit<SuggestProductState> {
  SuggestProductCubit()
      : super(
          SuggestProductInitial(),
        );

  void loadSuggestProduct() {
    emit(SuggestProductLoading());
    emit(
      SuggestProductLoaded(
        suggests: [
          ProductModel(
            images: [
              'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
              'https://product.hstatic.net/1000075078/product/1645963560_ca-phe-sua-da-min_d4560f2c59f34f4394f8cfb423f2f556.png',
            ],
            mainImage:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            description:
                'Cà phê Đắk Lắk nguyên chất được pha phin truyền thống '
                'kết hợp với sữa đặc tạo nên hương vị đậm đà, hài hòa giữa vị '
                'ngọt đầu lưỡi và vị đắng thanh thoát nơi hậu vị.',
            isFavorite: false,
            id: txtUnknown,
          ),
          ProductModel(
            images: [
              'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
              'https://product.hstatic.net/1000075078/product/1645963560_ca-phe-sua-da-min_d4560f2c59f34f4394f8cfb423f2f556.png',
            ],
            mainImage:
                'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            description:
                'Cà phê Đắk Lắk nguyên chất được pha phin truyền thống '
                'kết hợp với sữa đặc tạo nên hương vị đậm đà, hài hòa giữa vị '
                'ngọt đầu lưỡi và vị đắng thanh thoát nơi hậu vị.',
            isFavorite: false,
            id: txtUnknown,
          ),
          ProductModel(
            images: [
              'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
              'https://product.hstatic.net/1000075078/product/1645963560_ca-phe-sua-da-min_d4560f2c59f34f4394f8cfb423f2f556.png',
            ],
            mainImage:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            description:
                'Cà phê Đắk Lắk nguyên chất được pha phin truyền thống '
                'kết hợp với sữa đặc tạo nên hương vị đậm đà, hài hòa giữa vị '
                'ngọt đầu lưỡi và vị đắng thanh thoát nơi hậu vị.',
            isFavorite: false,
            id: txtUnknown,
          ),
          ProductModel(
            images: [
              'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
              'https://product.hstatic.net/1000075078/product/1645963560_ca-phe-sua-da-min_d4560f2c59f34f4394f8cfb423f2f556.png',
            ],
            mainImage:
                'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            description:
                'Cà phê Đắk Lắk nguyên chất được pha phin truyền thống '
                'kết hợp với sữa đặc tạo nên hương vị đậm đà, hài hòa giữa vị '
                'ngọt đầu lưỡi và vị đắng thanh thoát nơi hậu vị.',
            isFavorite: false,
            id: txtUnknown,
          ),
          ProductModel(
            images: [
              'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
              'https://product.hstatic.net/1000075078/product/1645963560_ca-phe-sua-da-min_d4560f2c59f34f4394f8cfb423f2f556.png',
            ],
            mainImage:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
            name: 'Cà Phê Sữa Đá',
            price: 25000,
            description:
                'Cà phê Đắk Lắk nguyên chất được pha phin truyền thống '
                'kết hợp với sữa đặc tạo nên hương vị đậm đà, hài hòa giữa vị '
                'ngọt đầu lưỡi và vị đắng thanh thoát nơi hậu vị.',
            isFavorite: false,
            id: txtUnknown,
          ),
        ],
      ),
    );
  }

  void setSuggestProduct(HomeBodyType type) async {}
}
