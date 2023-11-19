import 'package:dio/dio.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../../business_logic/repositories/slider_repository.dart';
import '../../models/slider_model.dart';
import '../../../exception/app_message.dart';

class SliderMockRepository extends SliderRepository {
  @override
  Future<ResponseModel<List<SliderModel>>> gets() async {
    return ResponseModel<List<SliderModel>>(
        type: ResponseModelType.success,
        data: [
          SliderModel(
            id: 'SLD1',
            image:
                'https://product.hstatic.net/1000075078/product/1669707374_1642353251-ca-phe-dam-vi-viet-tui-new_7fdd610e98f54bcbb9b74992c14d1aed_master.jpg',
            url: 'https://flutter.dev/',
          ),
          SliderModel(
            id: 'SLD2',
            image:
            'https://product.hstatic.net/1000075078/product/1669707374_1642353251-ca-phe-dam-vi-viet-tui-new_7fdd610e98f54bcbb9b74992c14d1aed_master.jpg',
            url: 'https://flutter.dev/',
          ),
          SliderModel(
            id: 'SLD3',
            image:
            'https://product.hstatic.net/1000075078/product/1669707374_1642353251-ca-phe-dam-vi-viet-tui-new_7fdd610e98f54bcbb9b74992c14d1aed_master.jpg',
            url: 'https://flutter.dev/',
          ),
        ]);
    return ResponseModel<List<SliderModel>>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi lấy App Bar',
      ),
    );
  }
}
