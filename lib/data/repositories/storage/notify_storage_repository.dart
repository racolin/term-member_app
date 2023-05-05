import 'package:dio/dio.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../../data/models/notify_model.dart';
import '../../../business_logic/repositories/notify_repository.dart';
import '../../../exception/app_exception.dart';
import '../../../exception/app_message.dart';

class NotifyStorageRepository extends NotifyRepository {

  @override
  Future<ResponseModel<bool>> checkNotify({required String id}) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<NotifyModel>>> gets() async {
    throw UnimplementedError();
  }
}
