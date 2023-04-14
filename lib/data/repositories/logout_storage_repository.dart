import 'package:flutter/services.dart';
import 'package:member_app/exception/app_exception.dart';
import '../../business_logic/repositories/logout_repository.dart';
import '../../data/services/secure_storage.dart';
import '../../exception/app_message.dart';

class LogoutStorageRepository extends LogoutRepository {
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
          messageType: AppMessageType.failure,
          title: 'Lỗi',
          content: 'Quá trình đăng xuất gặp vấn đề. Hãy thử lại!',
        ),
      );
    }
  }
}
