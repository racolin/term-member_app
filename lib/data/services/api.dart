import 'package:dio/dio.dart';
import 'package:member_app/data/models/token_model.dart';
import 'package:member_app/data/services/config.dart';
import 'package:member_app/data/services/secure_storage.dart';

class Api {

  static Dio authDio = _createDioWithAuth();

  static Dio notAuthDio = _createDioWithoutAuth();

  static Dio _createDioWithAuth() {
    var dio = Dio(BaseOptions(
      baseUrl: Environment.dev().url,
      receiveTimeout: 15000,
      connectTimeout: 15000,
      sendTimeout: 15000,
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

  static Dio _createDioWithoutAuth() {
    var dio = Dio(BaseOptions(
      baseUrl: Environment.dev().url,
      receiveTimeout: 15000,
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.addAll({
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    });

    return dio;
  }
}

class AppClientInterceptors extends QueuedInterceptorsWrapper {
  final SecureStorage storage = SecureStorage();

  AppClientInterceptors();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    TokenModel? token = await storage.getToken();
    if (token == null) {
      throw DioError(requestOptions: options);
    }
    bool expired = token.expiredTime < DateTime.now().microsecondsSinceEpoch;
    if (expired) {
      try {
        var response = await Api.notAuthDio.get(
          RouteApi.login,
          queryParameters: {
            'email': await storage.getEmail(),
          },
        );

        if (response.statusCode == 200) {
          if (response.data != false) {

            TokenModel tk = TokenModel.fromJson(response.data);

            await storage.persistToken(tk);
          }
        } else {
          throw DioError(requestOptions: options);
        }
      } on DioError catch(e) {
        handler.reject(e, true);
      }
    }
    options.headers.addAll(
      {
        'Authorization': 'Bearer ${storage.getToken()}',
      },
    );
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
    return handler.next(response);
  }
}
