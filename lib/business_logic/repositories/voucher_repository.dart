import '../../data/models/voucher_model.dart';

abstract class VoucherRepository {

  Future<List<VoucherModel>> getsAvailable();

  Future<List<VoucherModel>> getsUsed();
}