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

  ///
  /// Can throw PlatformException
  ///
  Future<void> persistToken(TokenModel token) async {
    await _storage.write(
      key: _accessTokenKey,
      value: token.accessToken,
    );
    await _storage.write(
      key: _refreshTokenKey,
      value: token.refreshToken,
    );
  }

  ///
  /// Can throw PlatformException
  ///
  Future<void> deleteToken() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  // ///
  // /// Can throw PlatformException
  // ///
  // Future<TokenModel?> getAccessToken() async {
  //   String? access = await _storage.read(key: _accessTokenKey);
  //   String? refresh = await _storage.read(key: _refreshTokenKey);
  //
  //   if (access != null && refresh != null) {
  //     return TokenModel(
  //       accessToken: access,
  //       refreshToken: refresh,
  //     );
  //   }
  //   return null;
  // }

  ///
  /// Can throw PlatformException
  ///
  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessTokenKey);
  }
  
  ///
  /// Can throw PlatformException
  ///
  Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshTokenKey);
  }
  
  ///
  /// Can throw PlatformException
  ///
  Future<void> deleteAll() async {
    return _storage.deleteAll();
  }
}