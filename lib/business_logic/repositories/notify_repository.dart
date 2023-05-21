import '../../data/models/notify_model.dart';
import '../../data/models/response_model.dart';

abstract class NotifyRepository {
  Future<ResponseModel<List<NotifyModel>>> gets();

  Future<ResponseModel<bool>> check({
    required String id,
  });

  Future<ResponseModel<bool>> checkAll();
}
