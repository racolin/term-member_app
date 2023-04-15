import 'package:dio/dio.dart';

import '../../data/models/product_category_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/product_option_model.dart';
import '../../business_logic/repositories/product_repository.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';

class ProductApiRepository extends ProductRepository {
  var _products = List.generate(
    40,
    (index) => ProductModel(
      id: 'PRODUCT-$index',
      name: 'Cà Phê Sữa Đá',
      cost: 20000 + index * 1000,
      image:
          'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
      images: [
        'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
        'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
        'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
        'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
      ],
      optionIds: ['OPTION-1', 'OPTION-3', 'OPTION-4'],
      description:
          'Cà phê Đắk Lắk nguyên chất được pha phin truyền thống kết hợp với sữa đặc'
          ' tạo nên hương vị đậm đà, hài hoà giữa vị ngọt đầu lưỡi và vị đắng thanh thoát.',
    ),
  );

  var _categories = <ProductCategoryModel>[];

  var _options = List.generate(
    4,
    (index) => ProductOptionModel(
      id: 'OPTION-$index',
      name: 'Size',
      minSelected: 1,
      maxSelected: 1,
      defs: ["OPTION-$index-1"],
      items: [
        ProductOptionItemModel(
          id: 'OPTION-$index-1',
          name: 'Nhỏ',
          cost: 35000,
          disable: true,
        ),
        ProductOptionItemModel(
          id: 'OPTION-$index-2',
          name: 'Vừa',
          cost: 39000,
          disable: false,
        ),
        ProductOptionItemModel(
          id: 'OPTION-$index-3',
          name: 'Lớn',
          cost: 45000,
          disable: false,
        ),
      ],
    ),
  );

  var _favorites = <String>[];

  @override
  Future<bool?> changeFavorite({required String id}) async {
    try {
      return _favorites.remove(id);
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi thay đổi yêu thích',
        ),
      );
    }
    return false;
  }

  @override
  Future<List<ProductCategoryModel>> getCategories() async {
    try {
      return _categories;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy danh sách category',
        ),
      );
    }
    return [];
  }

  @override
  Future<List<String>> getFavorites() async {
    try {
      return _favorites;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy danh sách yêu thích',
        ),
      );
    }
    return [];
  }

  @override
  Future<List<ProductOptionModel>> getOptions() async {
    try {
      return _options;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy danh sách lựa chọn',
        ),
      );
    }
    return [];
  }

  @override
  Future<List<ProductModel>> gets() async {
    try {
      return _products;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy danh sách sản phẩm',
        ),
      );
    }
    return [];
  }
}
