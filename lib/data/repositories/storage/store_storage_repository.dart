import 'package:dio/dio.dart';
import 'package:member_app/data/models/response_model.dart';
import 'package:member_app/data/models/store_detail_model.dart';

import '../../../data/models/store_model.dart';
import '../../../business_logic/repositories/store_repository.dart';
import '../../../exception/app_exception.dart';
import '../../../exception/app_message.dart';

class StoreStorageRepository extends StoreRepository {

  @override
  Future<ResponseModel<bool>> changeFavorite({required String id}) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<StoreDetailModel>> getDetail({required String id}) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<StoreModel>>> gets() async {
    throw UnimplementedError();
  }
}
