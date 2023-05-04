import '../../data/models/card_model.dart';
import '../../data/models/history_point_model.dart';
import '../../data/models/app_bar_model.dart';
import '../../data/models/response_model.dart';

abstract class MemberRepository {
  Future<ResponseModel<AppBarModel>> getAppBar();

  Future<ResponseModel<MapEntry<int, List<HistoryPointModel>>>> getHistoryPoint({
    int? page,
    int? limit,
  });

  Future<ResponseModel<CardModel>> getCard();
}
