import '../../data/models/response_model.dart';

abstract class AccountRepository {
  Future<ResponseModel<bool>> logout();
}
