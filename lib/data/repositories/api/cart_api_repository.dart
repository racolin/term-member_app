import 'dart:math';

import 'package:dio/dio.dart';

import '../../../business_logic/repositories/cart_repository.dart';
import '../../../presentation/res/strings/values.dart';
import '../../models/cart_checked_model.dart';
import '../../models/cart_detail_model.dart';
import '../../models/cart_model.dart';
import '../../../exception/app_message.dart';
import '../../models/cart_status_model.dart';
import '../../models/raw_failure_model.dart';
import '../../models/raw_success_model.dart';
import '../../models/response_model.dart';
import '../../services/api_client.dart';
import '../../services/api_config.dart';

class CartApiRepository extends CartRepository {
  final _dio = ApiClient.dioAuth;

  @override
  Future<ResponseModel<CartCheckedModel>> checkVoucher({
    required String? storeId,
    required String voucherId,
    required int categoryId,
    required List<CartProductModel> products,
  }) async {
    try {
      var res = await _dio.post(
        ApiRouter.cartCheckVoucher,
        data: {
          'storeId': storeId,
          'voucherId': voucherId,
          'categoryId': categoryId,
          'products': products
              .map(
                (e) => e.toMapCheck(),
              )
              .toList(),
        },
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<CartCheckedModel>(
        type: ResponseModelType.success,
        data: CartCheckedModel.fromMap(raw.data),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<CartCheckedModel>(
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
        return ResponseModel<CartCheckedModel>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<CartCheckedModel>(
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
  Future<ResponseModel<String>> create({
    required String? storeId,
    required int categoryId,
    required int payType,
    required String phone,
    required String receiver,
    String? voucherId,
    required int receivingTime,
    String? addressName,
    required List<CartProductModel> products,
  }) async {
    try {
      var res = await _dio.post(
        ApiRouter.cartCreate,
        data: {
          'storeId': storeId,
          'categoryId': categoryId,
          'payType': payType,
          'phone': phone,
          'receiver': receiver,
          'voucherId': voucherId,
          'receivingTime': receivingTime,
          'addressName': addressName,
          'products': products
              .map(
                (e) => e.toMapCheck(),
              )
              .toList(),
        },
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<String>(
        type: ResponseModelType.success,
        data: raw.data["id"],
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<String>(
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
        return ResponseModel<String>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<String>(
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
  Future<ResponseModel<CartDetailModel>> getDetailById({
    required String id,
  }) async {
    try {
      var res = await _dio.get(
        ApiRouter.cartGet(id),
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<CartDetailModel>(
        type: ResponseModelType.success,
        data: CartDetailModel.fromMap(raw.data),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<CartDetailModel>(
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
        return ResponseModel<CartDetailModel>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<CartDetailModel>(
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
  Future<ResponseModel<List<CartStatusModel>>> getStatuses() async {
    try {
      var res = await _dio.get(
        ApiRouter.cartStatusAll,
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<List<CartStatusModel>>(
        type: ResponseModelType.success,
        data: (raw.data as List).map(
              (e) => CartStatusModel.fromMap(e),
        ).toList(),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<List<CartStatusModel>>(
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
        return ResponseModel<List<CartStatusModel>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<List<CartStatusModel>>(
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
  Future<ResponseModel<MapEntry<int, List<CartModel>>>> getsByStatusId({
    required String statusId,
    int? page,
    int? limit,
  }) async {
    try {
      var res = await _dio.get(
        ApiRouter.cartStatusGet(statusId),
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      var raw = RawSuccessModel.fromMap(res.data);

      return ResponseModel<MapEntry<int, List<CartModel>>>(
        type: ResponseModelType.success,
        data: MapEntry<int, List<CartModel>>(
          raw.data['maxCount'] ?? 0,
          (raw.data['carts'] as List)
              .map((e) => CartModel.fromMap(e))
              .toList(),
        ),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<MapEntry<int, List<CartModel>>>(
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
        return ResponseModel<MapEntry<int, List<CartModel>>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<MapEntry<int, List<CartModel>>>(
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
  Future<ResponseModel<bool>> review({
    required String id,
    required int rate,
    String? review,
  }) async {
    try {
      var res = await _dio.post(
        ApiRouter.cartReview(id),
        data: {
          'rate': rate,
          'review': review,
        },
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
}
