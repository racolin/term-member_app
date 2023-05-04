import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:member_app/data/models/token_model.dart';
import 'package:member_app/data/services/api_config.dart';
import 'package:member_app/data/services/secure_storage.dart';
import 'package:member_app/exception/app_message.dart';

class ApiClient {
  static Dio dio = _createDio();

  static Dio _createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Environment.dev().url,
      receiveTimeout: 10000,
      connectTimeout: 10000,
      sendTimeout: 10000,
    ));

    dio.interceptors.addAll({
      AppClientInterceptors(),
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

  AppClientInterceptors();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.queryParameters['auth'] ?? false) {
      options.queryParameters.remove('auth');
      String? token = await _storage.getAccessToken();
      if (token == null) {
        return handler.reject(
          DioError(
            requestOptions: options,
            error: AppMessage(
              type: AppMessageType.failure,
              title: 'Chưa xác thực',
              content: 'Bạn cần đăng nhập để sử dụng các tính năng này.',
            ),
          ),
        );
      }
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    return handler.next(options);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    return handler.next(err);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.requestOptions.path == ApiRouter.authSmsVerify) {
      var token = TokenModel.fromJson(response.data);
      try {
        await _storage.persistToken(token);
      } on PlatformException catch (ex) {

      }
    }
    return handler.next(response);
  }
}
