import 'package:member_app/data/models/response_model.dart';

import '../../../data/models/notify_model.dart';
import '../../../business_logic/repositories/notify_repository.dart';

class NotifyStorageRepository extends NotifyRepository {

  @override
  Future<ResponseModel<bool>> check({required String id}) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<NotifyModel>>> gets() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> checkAll() {
    // TODO: implement checkAll
    throw UnimplementedError();
  }
}
