import '../../data/models/response_model.dart';

abstract class AccountRepository {

  ///
  /// Success: data = true, message = null (data always true)
  ///
  /// Failure: data = null, message != null
  ///
  Future<ResponseModel<void>> logout();

  ///
  /// Success: data is bool, message = null
  ///
  /// - data = true => logged in
  ///
  /// - data = false => not logged in
  ///
  /// Failure: data = null, message != null
  ///
  Future<ResponseModel<bool>> isLogin();
}
