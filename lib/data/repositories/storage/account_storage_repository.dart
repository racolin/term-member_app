import 'package:flutter/services.dart';
import 'package:member_app/exception/app_exception.dart';
import '../../../business_logic/repositories/account_repository.dart';
import '../../services/secure_storage.dart';
import '../../../exception/app_message.dart';

class AccountStorageRepository extends AccountRepository {
  final _storage = SecureStorage();

  ///
  /// Can throw AppException
  ///
  @override
  Future<void> logout() async {
    try {
      await _storage.deleteToken();
    } on PlatformException catch (ex) {
      throw AppException(
        message: AppMessage(
          type: AppMessageType.failure,
          title: 'Lỗi',
          content: 'Quá trình đăng xuất gặp vấn đề. Hãy thử lại!',
        ),
      );
    }
  }

  ///
  /// Without Exception
  ///
  Future<bool> isLogin() async {
    try {
      String? accessToken = await _storage.getAccessToken();
      return accessToken != null;
    } on PlatformException catch (ex) {
      return false;
    }
  }
}
