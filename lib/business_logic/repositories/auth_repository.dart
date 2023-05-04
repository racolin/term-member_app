import 'package:member_app/data/models/response_model.dart';

abstract class AuthRepository {
  Future<ResponseModel<bool>> login({
    required String phone,
  });

  Future<ResponseModel<bool>> register({
    required String phone,
    required String firstName,
    required String lastName,
    required int gender,
    required int dob,
  });

  Future<ResponseModel<bool>> otpCheck({
    required String phone,
    required String otp,
  });
}
