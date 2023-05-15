import 'package:dio/dio.dart';

import '../../models/product_category_model.dart';
import '../../models/product_model.dart';
import '../../models/product_option_model.dart';
import '../../../business_logic/repositories/product_repository.dart';
import '../../../exception/app_message.dart';
import '../../models/response_model.dart';

class ProductMockRepository extends ProductRepository {
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
      ],
      optionIds: ['OPTION-1', 'OPTION-3', 'OPTION-4'],
      description:
          'Cà phê Đắk Lắk nguyên chất được pha phin truyền thống kết hợp với sữa đặc'
          ' tạo nên hương vị đậm đà, hài hoà giữa vị ngọt đầu lưỡi và vị đắng thanh thoát.',
    ),
  );

  var _categories = <ProductCategoryModel>[
    ProductCategoryModel(
        id: '1',
        image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
        name: 'Món mới phải thử',
        productIds: [
          'PRODUCT-0',
          'PRODUCT-1',
          'PRODUCT-7',
          'PRODUCT-13',
          'PRODUCT-12',
          'PRODUCT-32',
        ]),
    ProductCategoryModel(
        id: '2',
        image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
        name: 'Cà phê',
        productIds: [
          'PRODUCT-0',
          'PRODUCT-1',
          'PRODUCT-7',
          'PRODUCT-13',
          'PRODUCT-12',
          'PRODUCT-32',
        ]),
    ProductCategoryModel(
        id: '3',
        image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
        name: 'CloudFee',
        productIds: [
          'PRODUCT-0',
          'PRODUCT-1',
          'PRODUCT-7',
          'PRODUCT-13',
          'PRODUCT-12',
          'PRODUCT-32',
        ]),
    ProductCategoryModel(
        id: '4',
        image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
        name: 'CloudTea',
        productIds: [
          'PRODUCT-0',
          'PRODUCT-1',
          'PRODUCT-7',
          'PRODUCT-13',
          'PRODUCT-12',
          'PRODUCT-32',
        ]),
    ProductCategoryModel(
        id: '5',
        image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
        name: 'Thưởng thức tại nhà',
        productIds: [
          'PRODUCT-0',
          'PRODUCT-1',
          'PRODUCT-7',
          'PRODUCT-13',
          'PRODUCT-12',
          'PRODUCT-32',
        ]),
    ProductCategoryModel(
        id: '6',
        image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
        name: 'Hi-Tea Healthy',
        productIds: [
          'PRODUCT-0',
          'PRODUCT-1',
          'PRODUCT-7',
          'PRODUCT-13',
          'PRODUCT-12',
          'PRODUCT-32',
        ]),
    ProductCategoryModel(
        id: '7',
        image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
        name: 'Trà trái cây - Trà sữa',
        productIds: [
          'PRODUCT-0',
          'PRODUCT-1',
          'PRODUCT-7',
          'PRODUCT-13',
          'PRODUCT-12',
          'PRODUCT-32',
        ]),
    ProductCategoryModel(
        id: '8',
        image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
        name: 'Bánh Snack',
        productIds: [
          'PRODUCT-0',
          'PRODUCT-1',
          'PRODUCT-7',
          'PRODUCT-13',
          'PRODUCT-12',
          'PRODUCT-32',
        ]),
    ProductCategoryModel(
        id: '9',
        image:
            'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
        name: 'Bánh Snack',
        productIds: [
          'PRODUCT-0',
          'PRODUCT-1',
          'PRODUCT-7',
          'PRODUCT-13',
          'PRODUCT-12',
          'PRODUCT-32',
        ]),
  ];

  var _options = [
    ProductOptionModel(
      id: 'OPTION-1',
      name: 'Size',
      minSelected: 1,
      maxSelected: 1,
      defaultSelect: ["OPTION-1-1"],
      optionItems: [
        ProductOptionItemModel(
          id: 'OPTION-1-1',
          name: 'Nhỏ',
          cost: 35000,
          disable: false,
        ),
        ProductOptionItemModel(
          id: 'OPTION-1-2',
          name: 'Vừa',
          cost: 39000,
          disable: true,
        ),
        ProductOptionItemModel(
          id: 'OPTION-1-3',
          name: 'Lớn',
          cost: 45000,
          disable: false,
        ),
      ],
    ),
    ProductOptionModel(
      id: 'OPTION-2',
      name: 'Topping',
      minSelected: 0,
      maxSelected: 2,
      defaultSelect: ["OPTION-2-1"],
      optionItems: [
        ProductOptionItemModel(
          id: 'OPTION-2-1',
          name: 'Thạch phô mai',
          cost: 5000,
          disable: false,
        ),
        ProductOptionItemModel(
          id: 'OPTION-2-2',
          name: 'Thạch dừa',
          cost: 7000,
          disable: true,
        ),
        ProductOptionItemModel(
          id: 'OPTION-2-3',
          name: 'Trân châu truyền thống',
          cost: 9000,
          disable: true,
        ),
      ],
    ),
    ProductOptionModel(
      id: 'OPTION-3',
      name: 'Lượng đường',
      minSelected: 0,
      maxSelected: 1,
      defaultSelect: ["OPTION-3-1"],
      optionItems: [
        ProductOptionItemModel(
          id: 'OPTION-3-1',
          name: 'Ít đường',
          cost: 1000,
          disable: false,
        ),
        ProductOptionItemModel(
          id: 'OPTION-3-2',
          name: 'Đường vừa phải',
          cost: 2000,
          disable: true,
        ),
        ProductOptionItemModel(
          id: 'OPTION-3-3',
          name: 'Nhiều đường',
          cost: 4000,
          disable: false,
        ),
      ],
    ),
    ProductOptionModel(
      id: 'OPTION-4',
      name: 'Hộp đựng',
      minSelected: 1,
      maxSelected: 1,
      defaultSelect: ["OPTION-4-1"],
      optionItems: [
        ProductOptionItemModel(
          id: 'OPTION-4-1',
          name: 'Nhựa dùng 1 lần',
          cost: 1000,
          disable: false,
        ),
        ProductOptionItemModel(
          id: 'OPTION-4-2',
          name: 'Nhựa sử dụng nhiều lần',
          cost: 5000,
          disable: false,
        ),
        ProductOptionItemModel(
          id: 'OPTION-4-3',
          name: 'Chai thuỷ tinh',
          cost: 10000,
          disable: true,
        ),
      ],
    ),
  ];

  var _favorites = <String>[
    'PRODUCT-1',
    'PRODUCT-4',
    'PRODUCT-30',
    'PRODUCT-12',
    'PRODUCT-19',
    'PRODUCT-15',
    'PRODUCT-32',
    'PRODUCT-17',
  ];

  @override
  Future<ResponseModel<bool>> changeFavorite({required String id}) async {
    return ResponseModel<bool>(
      type: ResponseModelType.success,
      data: _favorites.remove(id),
    );
    return ResponseModel<bool>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi thay đổi yêu thích',
      ),
    );
  }

  @override
  Future<ResponseModel<List<ProductCategoryModel>>> getCategories() async {
    return ResponseModel<List<ProductCategoryModel>>(
      type: ResponseModelType.success,
      data: _categories,
    );
    return ResponseModel<List<ProductCategoryModel>>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi lấy danh sách category',
      ),
    );
  }

  @override
  Future<ResponseModel<List<String>>> getFavorites() async {
    return ResponseModel<List<String>>(
      type: ResponseModelType.success,
      data: _favorites,
    );
    return ResponseModel<List<String>>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy danh sách yêu thích',
        ));
  }

  @override
  Future<ResponseModel<List<ProductOptionModel>>> getOptions() async {
    return ResponseModel<List<ProductOptionModel>>(
      type: ResponseModelType.success,
      data: _options,
    );
    return ResponseModel<List<ProductOptionModel>>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi lấy danh sách lựa chọn',
      ),
    );
  }

  @override
  Future<ResponseModel<List<ProductModel>>> gets() async {
    return ResponseModel<List<ProductModel>>(
      type: ResponseModelType.success,
      data: _products,
    );
    return ResponseModel<List<ProductModel>>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi lấy danh sách sản phẩm',
      ),
    );
  }

  @override
  Future<ResponseModel<List<String>>> getsSuggestion({
    int limit = 4,
  }) async {
    return ResponseModel<List<String>>(
      type: ResponseModelType.success,
      data: _products.sublist(0, 4).map((e) => e.id).toList(),
    );
    return ResponseModel<List<String>>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi lấy danh sách sản phẩm',
      ),
    );
  }
}
