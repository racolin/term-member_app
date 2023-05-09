import 'package:member_app/data/models/response_model.dart';

abstract class AuthRepository {

  ///
  /// Success: data = true, message = null (data always true)
  ///
  /// Failure: data = null, message != null
  ///
  Future<ResponseModel<bool>> login({
    required String phone,
  });

  ///
  /// Success: data = true, message = null (data always true)
  ///
  /// Failure: data = null, message != null
  ///
  Future<ResponseModel<bool>> register({
    required String phone,
    required String firstName,
    required String lastName,
    required int gender,
    required int dob,
  });

  ///
  /// Success: data = true, message = null (data always true)
  ///
  /// Failure: data = null, message != null
  ///
  Future<ResponseModel<bool>> otpCheck({
    required String phone,
    required String otp,
  });
}
