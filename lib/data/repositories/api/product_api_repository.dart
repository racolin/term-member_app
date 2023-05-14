import 'package:dio/dio.dart';

import '../../../presentation/res/strings/values.dart';
import '../../models/raw_failure_model.dart';
import '../../models/raw_success_model.dart';
import '../../services/api_client.dart';
import '../../models/product_category_model.dart';
import '../../models/product_model.dart';
import '../../models/product_option_model.dart';
import '../../../business_logic/repositories/product_repository.dart';
import '../../../exception/app_message.dart';
import '../../models/response_model.dart';
import '../../services/api_config.dart';

class ProductApiRepository extends ProductRepository {
  final _dioNoAuth = ApiClient.dioNoAuth;
  final _dioAuth = ApiClient.dioAuth;

  @override
  Future<ResponseModel<bool>> changeFavorite({required String id}) async {
    try {
      var res = await _dioAuth.patch(
        ApiRouter.productFavoriteUpdate(id),
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
  Future<ResponseModel<List<ProductCategoryModel>>> getCategories() async {
    try {
      var res = await _dioNoAuth.get(
        ApiRouter.productCategoryAll,
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<List<ProductCategoryModel>>(
        type: ResponseModelType.success,
        data: (raw.data as List)
            .map(
              (e) => ProductCategoryModel.fromMap(e),
            )
            .toList(),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<List<ProductCategoryModel>>(
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
        return ResponseModel<List<ProductCategoryModel>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<List<ProductCategoryModel>>(
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
  Future<ResponseModel<List<String>>> getFavorites() async {
    try {
      var res = await _dioAuth.get(
        ApiRouter.productFavoriteAll,
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<List<String>>(
        type: ResponseModelType.success,
        data: (raw.data['products'] is List)
            ? (raw.data['products'] as List).map<String>((e) => e as String).toList()
            : <String>[],
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<List<String>>(
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
        return ResponseModel<List<String>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<List<String>>(
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
  Future<ResponseModel<List<ProductOptionModel>>> getOptions() async {
    try {
      var res = await _dioNoAuth.get(
        ApiRouter.productOptionAll,
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<List<ProductOptionModel>>(
        type: ResponseModelType.success,
        data: (raw.data as List)
            .map(
              (e) => ProductOptionModel.fromMap(e),
            )
            .toList(),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<List<ProductOptionModel>>(
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
        return ResponseModel<List<ProductOptionModel>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<List<ProductOptionModel>>(
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
  Future<ResponseModel<List<ProductModel>>> gets() async {
    try {
      var res = await _dioNoAuth.get(
        ApiRouter.productAll,
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<List<ProductModel>>(
        type: ResponseModelType.success,
        data: (raw.data as List)
            .map(
              (e) => ProductModel.fromMap(e),
            )
            .toList(),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<List<ProductModel>>(
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
        return ResponseModel<List<ProductModel>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<List<ProductModel>>(
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
  Future<ResponseModel<List<String>>> getsSuggestion({
    int limit = 4,
  }) async {
    try {
      var res = await _dioAuth.get(
        ApiRouter.productSuggestion,
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<List<String>>(
        type: ResponseModelType.success,
        data: (raw.data['products'] is List)
            ? (raw.data['products'] as List).map<String>((e) => e as String).toList()
            : <String>[],
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<List<String>>(
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
        return ResponseModel<List<String>>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<List<String>>(
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
