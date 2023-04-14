import '../../data/models/notify_model.dart';

abstract class NotifyRepository {
  Future<List<NotifyModel>> gets();

  Future<bool?> checkNotify({
    required String id,
  });
}
