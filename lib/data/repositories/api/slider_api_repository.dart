import 'package:dio/dio.dart';

import '../../models/response_model.dart';
import '../../services/api_client.dart';
import '../../../business_logic/repositories/slider_repository.dart';
import '../../models/slider_model.dart';
import '../../../exception/app_message.dart';
import '../../../presentation/res/strings/values.dart';
import '../../models/raw_failure_model.dart';
import '../../models/raw_success_model.dart';
import '../../services/api_config.dart';

class SliderApiRepository extends SliderRepository {
  final _dio = ApiClient.dioNoAuth;

  @override
  Future<ResponseModel<List<SliderModel>>> gets() async {
    try {
      var res = await _dio.get(
        ApiRouter.memberSliders,
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<List<SliderModel>>(
        type: ResponseModelType.success,
        data: (raw.data as List).map(
          (e) => SliderModel.fromMap(e),
        ).toList(),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<List<SliderModel>>(
          type: ResponseModelType.failure,
          message: ex.error,
        );
      } else {
        var raw = RawFailureModel.fromMap(
          ex.response?.data ??
              {
                'statusCode': 444,
                'message': 'Không có dữ liệu trả về!',
              },
        );
        return ResponseModel<List<SliderModel>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<List<SliderModel>>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }
}
