import 'package:member_app/data/models/response_model.dart';

import '../../../data/models/voucher_model.dart';
import '../../../business_logic/repositories/voucher_repository.dart';

class VoucherStorageRepository extends VoucherRepository {
  @override
  Future<ResponseModel<List<VoucherModel>>> getsAvailable() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<VoucherModel>>> getsUsed() async {
    throw UnimplementedError();
  }
}
