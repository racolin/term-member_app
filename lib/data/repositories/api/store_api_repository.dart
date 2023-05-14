import 'package:dio/dio.dart';
import 'package:member_app/data/models/response_model.dart';
import 'package:member_app/data/models/store_detail_model.dart';

import '../../../presentation/res/strings/values.dart';
import '../../models/raw_failure_model.dart';
import '../../models/raw_success_model.dart';
import '../../models/store_model.dart';
import '../../../business_logic/repositories/store_repository.dart';
import '../../../exception/app_message.dart';
import '../../services/api_client.dart';
import '../../services/api_config.dart';

class StoreApiRepository extends StoreRepository {
  final _dioAuth = ApiClient.dioAuth;
  final _dioNoAuth = ApiClient.dioNoAuth;
  @override
  Future<ResponseModel<bool>> changeFavorite({required String id}) async {
    try {
      var res = await _dioAuth.patch(
        ApiRouter.storeFavoritePatch(id),
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: raw.success ?? false,
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<bool>(
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
        return ResponseModel<bool>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<bool>(
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
  Future<ResponseModel<StoreDetailModel>> getDetail(
      {required String id}) async {
    try {
      var res = await _dioAuth.get(
        ApiRouter.storeGet(id),
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<StoreDetailModel>(
        type: ResponseModelType.success,
        data: StoreDetailModel.fromMap(raw.data),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<StoreDetailModel>(
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
        return ResponseModel<StoreDetailModel>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<StoreDetailModel>(
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
  Future<ResponseModel<List<StoreModel>>> gets() async {
    try {
      var res = await _dioNoAuth.get(
        ApiRouter.storeShort,
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<List<StoreModel>>(
        type: ResponseModelType.success,
        data: (raw.data as List).map(
              (e) => StoreModel.fromMap(e),
        ).toList(),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<List<StoreModel>>(
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
        return ResponseModel<List<StoreModel>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<List<StoreModel>>(
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
