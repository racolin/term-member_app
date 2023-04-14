import '../../data/models/card_model.dart';
import '../../data/models/point_history_model.dart';
import '../../data/models/app_bar_model.dart';

abstract class MemberRepository {
  Future<AppBarModel?> getAppBar();

  Future<List<HistoryPointModel>> getHistoryPoint({
    int? page,
    int? limit,
  });

  Future<CardModel?> getCard();
}
