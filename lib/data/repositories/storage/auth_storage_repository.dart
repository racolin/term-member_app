import '../../../data/models/response_model.dart';
import '../../../business_logic/repositories/auth_repository.dart';

class AuthStorageRepository extends AuthRepository {
  @override
  Future<ResponseModel<bool>> login({
    required String phone,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> otpCheck({
    required String phone,
    required String otp,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> register({
    required String phone,
    required String firstName,
    required String lastName,
    required int gender,
    required int dob,
  }) {
    throw UnimplementedError();
  }
}
