import 'package:dio/dio.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../../data/models/app_bar_model.dart';
import '../../../data/models/card_model.dart';
import '../../../data/models/history_point_model.dart';
import '../../../business_logic/repositories/member_repository.dart';
import '../../../exception/app_message.dart';
import '../../../presentation/res/strings/values.dart';
import '../../models/raw_failure_model.dart';
import '../../models/raw_success_model.dart';
import '../../services/api_client.dart';
import '../../services/api_config.dart';

class MemberApiRepository extends MemberRepository {
  final _dio = ApiClient.dio;

  @override
  Future<ResponseModel<AppBarModel>> getAppBar() async {
    try {
      var res = await _dio.get(
        ApiRouter.appAppbar,
        queryParameters: {'auth': true},
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<AppBarModel>(
        type: ResponseModelType.success,
        data: AppBarModel.fromMap(raw.data),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<AppBarModel>(
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
        return ResponseModel<AppBarModel>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<AppBarModel>(
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

  @override
  Future<ResponseModel<CardModel>> getCard() async {
    try {
      var res = await _dio.get(
        ApiRouter.memberRankCard,
        queryParameters: {'auth': true},
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<CardModel>(
        type: ResponseModelType.success,
        data: CardModel.fromMap(raw.data),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<CardModel>(
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
        return ResponseModel<CardModel>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<CardModel>(
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

  @override
  Future<ResponseModel<MapEntry<int, List<HistoryPointModel>>>>
      getHistoryPoint({
    int? page,
    int? limit,
  }) async {
    try {
      var res = await _dio.get(
        ApiRouter.memberDataPointHistory,
        queryParameters: {
          'auth': true,
          'page': page,
          'limit': limit,
        },
      );
      var raw = RawSuccessModel.fromMap(res.data);

      return ResponseModel<MapEntry<int, List<HistoryPointModel>>>(
        type: ResponseModelType.success,
        data: MapEntry<int, List<HistoryPointModel>>(
          raw.data['maxCount'] ?? 0,
          (raw.data['historyPoints'] as List)
              .map((e) => HistoryPointModel.fromMap(e))
              .toList(),
        ),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<MapEntry<int, List<HistoryPointModel>>>(
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
        return ResponseModel<MapEntry<int, List<HistoryPointModel>>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<MapEntry<int, List<HistoryPointModel>>>(
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
