import '../../data/models/response_model.dart';
import '../../data/models/voucher_model.dart';

abstract class VoucherRepository {

  Future<ResponseModel<List<VoucherModel>>> getsAvailable();

  Future<ResponseModel<List<VoucherModel>>> getsUsed();
}