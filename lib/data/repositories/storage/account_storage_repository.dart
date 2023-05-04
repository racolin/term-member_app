import 'package:flutter/services.dart';

import '../../../data/models/response_model.dart';
import '../../../business_logic/repositories/account_repository.dart';
import '../../services/secure_storage.dart';
import '../../../exception/app_message.dart';

class AccountStorageRepository extends AccountRepository {
  final _storage = SecureStorage();

  @override
  Future<ResponseModel<bool>> logout() async {
    try {
      await _storage.deleteToken();
      return ResponseModel<bool>(
        type: ResponseType.success,
        data: true,
      );
    } on PlatformException catch (ex) {
      return ResponseModel<bool>(
        type: ResponseType.failure,
        message: AppMessage(
          type: AppMessageType.failure,
          title: 'Có lỗi',
          content: 'Quá trình đăng xuất gặp vấn đề. Hãy thử lại!',
          description: ex.toString(),
        ),
      );
    }
  }

  @override
  Future<ResponseModel<bool>> isLogin() async {
    try {
      String? accessToken = await _storage.getAccessToken();
      return ResponseModel<bool>(
        type: ResponseType.success,
        data: accessToken != null,
      );
    } on PlatformException catch (ex) {
      return ResponseModel<bool>(
        type: ResponseType.failure,
        message: AppMessage(
          type: AppMessageType.failure,
          title: 'Có lỗi!',
          content: 'Lỗi khi kiểm tra trạng thái đăng nhập',
          description: ex.toString(),
        ),
      );
    }
  }
}
