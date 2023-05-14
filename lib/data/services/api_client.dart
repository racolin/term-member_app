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
  static Dio? _dioAuth;

  static Dio get dioAuth {
    _dioAuth ??= _createDioAuth();
    return _dioAuth!;
  }

  static Dio _createDioAuth() {
    var dio = Dio(BaseOptions(
      baseUrl: Environment.env().api,
      receiveTimeout: 10000,
      connectTimeout: 10000,
      sendTimeout: 10000,
    ));

    dio.interceptors.addAll({
      AuthInterceptor(
        dioNoAuth: dioNoAuth,
        storage: SecureStorage(),
      ),
      LogInterceptor(
        request: false,
        requestBody: true,
        responseBody: true,
      ),
    });

    return dio;
  }

  static Dio? _dioNoAuth;

  static Dio get dioNoAuth {
    _dioNoAuth ??= _createDioNoAuth();
    return _dioNoAuth!;
  }

  static Dio _createDioNoAuth() {
    var dio = Dio(BaseOptions(
      baseUrl: Environment.env().api,
      receiveTimeout: 10000,
      connectTimeout: 10000,
      sendTimeout: 10000,
    ));

    dio.interceptors.addAll({
      NoAuthInterceptor(
        storage: SecureStorage(),
      ),
      LogInterceptor(
        responseBody: true,
      ),
    });

    return dio;
  }
}

class AuthInterceptor extends QueuedInterceptor {
  final SecureStorage _storage;
  final Dio _dioNoAuth;

  AuthInterceptor({
    required Dio dioNoAuth,
    required SecureStorage storage,
  })  : _dioNoAuth = dioNoAuth,
        _storage = storage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // print('======================');
    // print('auth-request-${options.path}');
    var res = await _storage.getToken();
    if (res.type == ResponseModelType.success) {
      // print(res.data.toMap());
      var token = res.data;
      var expToken = _storage.hasExpired(
        token.accessToken,
        15000,
      );
      if (expToken) {
        options.headers.addAll(
          {'Authorization': 'Bearer ${token.accessToken}'},
        );
      } else {
        var expRefreshToken = _storage.hasExpired(
          token.refreshToken,
          15000,
        );
        if (expRefreshToken) {

          var refresh = await _dioNoAuth.post(
            ApiRouter.authRefresh,
            options: Options(
              headers: {'Authorization': 'Bearer ${token.refreshToken}'},
            ),
          );

          var resRefresh = RawSuccessModel.fromMap(refresh.data);
          var newToken = TokenModel.fromMap(resRefresh.data);
          await _storage.persistToken(newToken);
          options.headers
              .addAll({'Authorization': 'Bearer ${newToken.accessToken}'});
        } else {
          return handler.reject(
            DioError(
              requestOptions: options,
              error: AppMessage(
                type: AppMessageType.logout,
                title: txtErrorTitle,
                content: 'Bạn cần đăng nhập lại!',
              ),
            ),
          );
        }
      }
    } else {
      // print('auth-request-auth-failure-');
      return handler.reject(
        DioError(
          requestOptions: options,
          error: res.message,
        ),
      );
    }
    // print('auth-request-end');
    return handler.next(options);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    // Refresh here
    // print('======================');
    // print('auth-error-${err.requestOptions.path}');
    // print('auth-error-code-${err.response?.statusCode}');
    if (err.response?.statusCode == 401) {
      err.error = AppMessage(
        type: AppMessageType.logout,
        title: txtErrorTitle,
        content: 'Gặp vấn đề khi lấy lại phiên đăng nhập. Hãy thử lại',
      );
    }

    if (err.response?.statusCode == 403) {
      // print('auth-error-logout');
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
    return handler.next(response);
  }
}

class NoAuthInterceptor extends Interceptor {
  final SecureStorage _storage;

  NoAuthInterceptor({
    required SecureStorage storage,
  }) : _storage = storage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return handler.next(options);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.requestOptions.path == ApiRouter.authRefresh &&
        err.response?.statusCode == 401) {
      err.error = AppMessage(
        type: AppMessageType.logout,
        title: txtErrorTitle,
        content: 'Không thể lấy phiên đăng nhập. Hãy đăng nhập lại!',
        description: 'Lỗi 401 khi refresh token',
      );
    }
    return handler.next(err);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.requestOptions.path == ApiRouter.authRefresh) {
      // print('Refresh Token');
      // print(response.data);
    }
    if (response.requestOptions.path == ApiRouter.authSmsVerify) {
      // print('auth-response-otp');
      var res = RawSuccessModel.fromMap(response.data);
      var token = TokenModel.fromMap(res.data);
      await _storage.persistToken(token);
    }
    return handler.next(response);
  }
}
