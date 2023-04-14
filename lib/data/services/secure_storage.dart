import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:member_app/data/models/token_model.dart';

class SecureStorage {
  static SecureStorage? _instance;

  factory SecureStorage() => _instance ??= SecureStorage._(
        const FlutterSecureStorage(),
      );

  SecureStorage._(this._storage);

  final FlutterSecureStorage _storage;
  static const _accessTokenKey = 'ACCESS_TOKEN';
  static const _refreshTokenKey = 'REFRESH_TOKEN';
  static const _expiredTimeKey = 'EXPIRED_TIME';

  static const _emailKey = 'EMAIL';

  Future<void> persistToken(TokenModel token) async {
    try {
      await _storage.write(
        key: _accessTokenKey,
        value: token.accessToken,
      );
      await _storage.write(
        key: _refreshTokenKey,
        value: token.refreshToken,
      );
    } on PlatformException catch(ex) {

    }
  }

  Future<bool> hasToken() async {
    var value = await _storage.read(key: _accessTokenKey);
    return value != null;
  }

  Future<TokenModel?> getToken() async {
    String? access = await _storage.read(key: _accessTokenKey);
    String? refresh = await _storage.read(key: _refreshTokenKey);
    String? time = await _storage.read(key: _expiredTimeKey);

    if (access != null && refresh != null && time != null) {
      return TokenModel(
        accessToken: access,
        refreshToken: refresh,
      );
    }
    return null;
  }

  Future<void> deleteAll() async {
    return _storage.deleteAll();
  }

  Future<String?> getEmail() async {
    return await _storage.read(key: _emailKey);
  }

  Future<bool> hasEmail() async {
    var value = await _storage.read(key: _emailKey);
    return value != null;
  }
}
