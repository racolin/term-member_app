import 'package:dio/dio.dart';

import '../../../business_logic/repositories/cart_template_repository.dart';
import '../../../data/models/cart_template_model.dart';
import '../../../exception/app_message.dart';
import '../../models/response_model.dart';

class CartTemplateMockRepository extends CartTemplateRepository {
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
  Future<ResponseModel<bool>> arrange({
    required List<String> ids,
  }) async {
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

    return ResponseModel<bool>(
      type: ResponseModelType.success,
      data: true,
      // data: false,
    );
    return ResponseModel<bool>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Có lỗi!',
        content: 'Gặp sự cố khi sắp xếp đơn hàng mẫu',
      ),
    );
  }

  @override
  Future<ResponseModel<String>> create({
    required String name,
    required List<CartTemplateProductModel> products,
  }) async {
    if (_list.length < 12) {
      _list.add(
        CartTemplateModel(
          id: 'TEMPLATE-$_count',
          name: name,
          index: _count,
          products: products,
        ),
      );
      _count++;
      return ResponseModel<String>(
        type: ResponseModelType.success,
        data: 'TEMPLATE-${_count - 1}',
        // data: false,
      );
    } else {
      return ResponseModel<String>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Thất bại!',
          content: 'Số lượng đơn hàng mẫu của bạn đã đạt mức giới hạn!',
        ),
      );
    }
    return ResponseModel<String>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Có lỗi!',
        content: 'Gặp sử cố khi tạo đơn hàng mẫu!',
      ),
    );
  }

  @override
  Future<ResponseModel<bool>> delete({required String id}) async {
    if (_list.isNotEmpty) {
      _list.removeWhere((e) => e.id == id);
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: true,
        // data: false,
      );
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Có lỗi!',
          content: 'Gặp sự cố khi xoá đơn hàng mẫu',
        ),
      );
    }
    return ResponseModel<bool>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Có lỗi!',
        content: 'Gặp sự cố khi xoá đơn hàng mẫu',
      ),
    );
  }

  @override
  Future<ResponseModel<bool>> update({
    required String id,
    required String name,
    required List<CartTemplateProductModel> products,
  }) async {
    int index = _list.indexWhere((e) => e.id == id);
    if (index == -1 ) {
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        // data: true,
        data: false,
      );
    }
    _list[index].copyWith(
      name: name,
      products: products,
    );
    return ResponseModel<bool>(
      type: ResponseModelType.success,
      data: true,
      // data: false,
    );
    return ResponseModel<bool>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Có lỗi!',
        content: 'Gặp sự cố khi sửa đơn hàng mẫu!',
      ),
    );
  }

  @override
  Future<ResponseModel<MapEntry<int, List<CartTemplateModel>>>> gets() async {
    return ResponseModel<MapEntry<int, List<CartTemplateModel>>>(
      type: ResponseModelType.success,
      data: MapEntry(12, _list),
      // data: false,
    );
    return ResponseModel<MapEntry<int, List<CartTemplateModel>>>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Có lỗi!',
        content: 'Gặp sự cố khi lấy danh sách đơn hàng mẫu',
      ),
    );
  }
}
