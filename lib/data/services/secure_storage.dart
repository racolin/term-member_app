import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:member_app/data/models/token_model.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../exception/app_message.dart';
import '../models/response_model.dart';

class SecureStorage {
  static SecureStorage? _instance;

  factory SecureStorage() => _instance ??= SecureStorage._(
        const FlutterSecureStorage(),
      );

  SecureStorage._(this._storage);

  final FlutterSecureStorage _storage;
  static const _accessTokenKey = 'ACCESS_TOKEN';
  static const _refreshTokenKey = 'REFRESH_TOKEN';

  Future<ResponseModel<bool>> persistToken(TokenModel token) async {
    try {
      await _storage.write(
        key: _accessTokenKey,
        value: token.accessToken,
      );
      await _storage.write(
        key: _refreshTokenKey,
        value: token.refreshToken,
      );
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: true,
      );
    } on PlatformException catch (ex) {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: 'Có lỗi!',
          type: AppMessageType.error,
          content: 'Có lỗi xảy ra khi lưu phiên đăng nhập',
          description: ex.message,
        ),
      );
    } on Exception catch (ex) {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Có lỗi!',
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }

  Future<ResponseModel<bool>> deleteToken() async {
    try {
      await _storage.delete(key: _accessTokenKey);
      await _storage.delete(key: _refreshTokenKey);
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: true,
      );
    } on PlatformException catch (ex) {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Gặp sự cố khi đăng xuất, hãy thử lại.',
          description: ex.message,
        ),
      );
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

  Future<ResponseModel<TokenModel>> getToken() async {
    try {
      String? access = await _storage.read(key: _accessTokenKey);
      String? refresh = await _storage.read(key: _refreshTokenKey);

      if (access != null && refresh != null) {
        return ResponseModel<TokenModel>(
          type: ResponseModelType.success,
          data: TokenModel(
            accessToken: access,
            refreshToken: refresh,
          ),
        );
      }
      return ResponseModel<TokenModel>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.failure,
          title: txtFailureTitle,
          content: 'Dữ liệu không có dữ liệu hoặc không đúng định dạng!',
        ),
      );
    } on PlatformException catch (ex) {
      return ResponseModel<TokenModel>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.error,
          title: txtErrorTitle,
          content: 'Gặp sự cố khi lấy phiên đăng nhập!',
          description: ex.message,
        ),
      );
    } on Exception catch (ex) {
      return ResponseModel<TokenModel>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.error,
          title: txtErrorTitle,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }

  Future<ResponseModel<String>> getAccessToken() async {
    try {
      String? accessToken = await _storage.read(key: _accessTokenKey);
      if (accessToken != null) {
        return ResponseModel<String>(
          type: ResponseModelType.success,
          data: accessToken,
        );
      }
      return ResponseModel<String>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.failure,
          title: txtFailureTitle,
          content: 'Dữ liệu không có dữ liệu hoặc không đúng định dạng!',
        ),
      );
    } on PlatformException catch (ex) {
      return ResponseModel<String>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.error,
          title: txtErrorTitle,
          content: 'Có lỗi xảy ra khi lấy phiên đăng nhập!\nHãy thử lại',
          description: ex.message,
        ),
      );
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

  Future<ResponseModel<String>> getRefreshToken() async {
    try {
      String? refreshToken = await _storage.read(key: _refreshTokenKey);
      if (refreshToken != null) {
        return ResponseModel<String>(
          type: ResponseModelType.success,
          data: refreshToken,
        );
      }
      return ResponseModel<String>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.failure,
          title: txtFailureTitle,
          content: 'Dữ liệu không có dữ liệu hoặc không đúng định dạng!',
        ),
      );
    } on PlatformException catch (ex) {
      return ResponseModel<String>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.error,
          title: txtErrorTitle,
          content: 'Có lỗi xảy ra khi làm mới phiên đăng nhập!\nHãy thử lại',
          description: ex.message,
        ),
      );
    } on Exception catch (ex) {
      return ResponseModel<String>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.error,
          title: txtErrorTitle,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }

  Future<ResponseModel<bool>> deleteAll() async {
    try {
      await _storage.deleteAll();
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: true,
      );
    } on PlatformException catch (ex) {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Gặp sự cố khi đăng xuất, hãy thử lại.',
          description: ex.message,
        ),
      );
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
