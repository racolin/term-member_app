import '../../data/models/card_model.dart';
import '../../data/models/history_point_model.dart';
import '../../data/models/app_bar_model.dart';

abstract class MemberRepository {
  Future<AppBarModel?> getAppBar();

  Future<MapEntry<int, List<HistoryPointModel>>> getHistoryPoint({
    int? page,
    int? limit,
  });

  Future<CardModel?> getCard();
}
