import 'package:dio/dio.dart';

import '../../models/response_model.dart';
import '../../services/api_client.dart';
import '../../../business_logic/repositories/news_repository.dart';
import '../../models/news_model.dart';
import '../../../exception/app_message.dart';
import '../../../presentation/res/strings/values.dart';
import '../../models/raw_failure_model.dart';
import '../../models/raw_success_model.dart';
import '../../services/api_config.dart';

class NewsApiRepository extends NewsRepository {
  final _dio = ApiClient.dioNoAuth;

  @override
  Future<ResponseModel<List<NewsModel>>> gets() async {
    try {
      var res = await _dio.get(
        ApiRouter.news,
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<List<NewsModel>>(
        type: ResponseModelType.success,
        data: (raw.data as List).map(
          (e) => NewsModel.fromMap(e),
        ).toList(),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<List<NewsModel>>(
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
        return ResponseModel<List<NewsModel>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<List<NewsModel>>(
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
