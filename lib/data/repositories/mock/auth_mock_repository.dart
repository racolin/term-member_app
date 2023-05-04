import 'package:dio/dio.dart';

import '../../../business_logic/repositories/auth_repository.dart';
import '../../../exception/app_exception.dart';
import '../../../exception/app_message.dart';

class AuthMockRepository extends AuthRepository {
  @override
  Future<bool?> login({
    required String phone,
  }) async {
    try {
      return true;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi login',
        ),
      );
    }
    return false;
  }

  @override
  Future<bool?> otpCheck({
    required String phone,
    required String otp,
  }) async {
    try {
      return true;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi check OTP',
        ),
      );
    }
    return false;
  }

  @override
  Future<bool?> register({
    required String phone,
    required String firstName,
    required String lastName,
    required int gender,
    required int dob,
  }) async {
    try {
      return true;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi register',
        ),
      );
    }
    return false;
  }
}
