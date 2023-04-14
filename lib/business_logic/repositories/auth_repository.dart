abstract class AuthRepository {
  Future<bool?> login({
    required String phone,
  });

  Future<bool?> register({
    required String phone,
    required String firstName,
    required String lastName,
    required int gender,
    required int dob,
  });

  Future<bool?> otpCheck({
    required String phone,
    required String otp,
  });
}
