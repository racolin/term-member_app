import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:member_app/data/models/raw_success_model.dart';
import 'package:member_app/data/models/token_model.dart';
import 'package:member_app/data/services/api_config.dart';
import 'package:member_app/data/services/secure_storage.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../models/response_model.dart';

class ApiClient {
  static Dio dio = _createDio();

  static Dio _createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Environment.env().api,
      receiveTimeout: 50000,
      connectTimeout: 50000,
      sendTimeout: 50000,
    ));

    dio.interceptors.addAll({
      AppClientInterceptors(dio: dio),
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    });

    return dio;
  }
}

class AppClientInterceptors extends QueuedInterceptorsWrapper {
  final SecureStorage _storage = SecureStorage();
  final Dio dio;

  AppClientInterceptors({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.queryParameters['auth'] ?? false) {
      var res = await _storage.getAccessToken();
      if (res.type == ResponseModelType.success) {
        var token = res.data;
        options.headers.addAll({'Authorization': 'Bearer $token'});
      } else {
        return handler.reject(
          DioError(
            requestOptions: options,
            error: res.message,
          ),
        );
      }
    }
    // if (options.path == ApiRouter.authRefresh) {
    //   var res = await _storage.getRefreshToken();
    //   if (res.type == ResponseModelType.success) {
    //     var refreshToken = res.data;
    //     options.headers.addAll({'Authorization': 'Bearer $refreshToken'});
    //   } else {
    //     return handler.reject(
    //       DioError(
    //         requestOptions: options,
    //         error: res.message,
    //       ),
    //     );
    //   }
    // }
    print('1212121xxx');
    print(options.path);
    print(options.headers);
    options.queryParameters.remove('auth');
    return handler.next(options);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    // Refresh here
    print('error');
    print(err.response?.statusCode);
    if (err.response?.statusCode == 401) {
      print(1212121);
      try {
        var res = await _storage.getRefreshToken();
        _storage.getRefreshToken().then((value) => print(value.data));
        _storage.getAccessToken().then((value) => print(value.data));
        if (res.type == ResponseModelType.success) {
          var refreshToken = res.data;
          await dio.post(
              ApiRouter.authRefresh,
              options: Options(headers: {'Authorization': 'Bearer $refreshToken'})
          );
          print(1231);
          var response = await dio.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            ),
          );
          return handler.resolve(response);
        } else {
          return handler.reject(
            DioError(
              requestOptions: err.requestOptions,
              error: res.message,
            ),
          );
        }
      } on DioError catch (ex) {
        return handler.next(ex);
      }
    }

    if (err.response?.statusCode == 403) {
      await _storage.deleteToken();
      err.error = AppMessage(
        type: AppMessageType.logout,
        title: txtLogOut,
        content: 'Phiên đăng nhập của bạn đã bị xoá. Đăng nhập lại!',
      );
    }
    return handler.next(err);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.requestOptions.path == ApiRouter.authSmsVerify) {
      var res = RawSuccessModel.fromMap(response.data);
      var token = TokenModel.fromJson(res.data);
      await _storage.persistToken(token);
    }
    if (response.requestOptions.path == ApiRouter.authRefresh) {
      var token = TokenModel.fromJson(response.data);
      await _storage.persistToken(token);
    }
    return handler.next(response);
  }
}
