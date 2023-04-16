import 'package:dio/dio.dart';

import '../../business_logic/repositories/cart_template_repository.dart';
import '../../data/models/cart_template_model.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';

class CartTemplateApiRepository extends CartTemplateRepository {
  var _count = 8;
  var _list = List.generate(
    8,
    (index) => CartTemplateModel(
      id: 'TEMPLATE-$index',
      name: 'Template $index',
      index: index,
      products: [
        const CartTemplateProductModel(
          id: 'PRODUCT-01',
          amount: 1,
          options: ['OPTION-2', 'OPTION-3'],
        ),
        const CartTemplateProductModel(
          id: 'PRODUCT-01',
          amount: 3,
          options: ['OPTION-1', 'OPTION-3'],
        ),
        const CartTemplateProductModel(
          id: 'PRODUCT-05',
          amount: 1,
          options: ['OPTION-01'],
        ),
      ],
    ),
  );

  @override
  Future<bool?> arrange({
    required List<String> ids,
  }) async {
    try {
      _list = List.generate(
        ids.length,
        (index) {
          var i = ids[index].split('-')[1];
          return CartTemplateModel(
            id: ids[index],
            name: 'Template $i',
            index: index,
            products: [
              const CartTemplateProductModel(
                id: 'PRODUCT-01',
                amount: 1,
                options: ['OPTION-2', 'OPTION-3'],
              ),
              const CartTemplateProductModel(
                id: 'PRODUCT-01',
                amount: 3,
                options: ['OPTION-1', 'OPTION-3'],
              ),
              const CartTemplateProductModel(
                id: 'PRODUCT-05',
                amount: 1,
                options: ['OPTION-01'],
              ),
            ],
          );
        },
      );
      return true;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi sắp xếp Cart Template',
        ),
      );
    }
    return false;
  }

  @override
  Future<String?> create({
    required String name,
    required List<CartTemplateProductModel> products,
  }) async {
    if (_list.length < 12) {
      try {
        _list.add(
          CartTemplateModel(
            id: 'TEMPLATE-$_count',
            name: name,
            index: _count,
            products: products,
          ),
        );
        _count++;
        return 'TEMPLATE-${_count - 1}';
      } on DioError catch (ex) {
        throw AppException(
          message: AppMessage(
            messageType: AppMessageType.error,
            title: 'Lỗi mạng!',
            content: 'Gặp sử cố khi tạo Cart Template!',
          ),
        );
      }
    }
    return null;
  }

  @override
  Future<bool?> delete({required String id}) async {
    if (_list.isNotEmpty) {
      try {
        _list.removeWhere((e) => e.id == id);
        return true;
      } on DioError catch (ex) {
        throw AppException(
          message: AppMessage(
            messageType: AppMessageType.error,
            title: 'Lỗi mạng!',
            content: 'Gặp sự cố khi xoá Cart Template',
          ),
        );
      }
    }
    return false;
  }

  @override
  Future<bool?> edit({
    required String id,
    required String name,
    required List<CartTemplateProductModel> products,
  }) async {
    try {
      int index = _list.indexWhere((e) => e.id == id);
      if (index == -1) {
        return false;
      }
      _list[index].copyWith(
        name: name,
        products: products,
      );
      return true;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi sửa Cart Template',
        ),
      );
    }
    return false;
  }

  @override
  Future<MapEntry<int, List<CartTemplateModel>>> gets() async {
    try {
      return MapEntry(12, _list);
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy danh sách Cart Template',
        ),
      );
    }
  }
}
