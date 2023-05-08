import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/history_point_model.dart';
import 'package:member_app/data/models/paging_model.dart';

import '../../business_logic/repositories/member_repository.dart';
import '../../exception/app_message.dart';
import '../../presentation/res/strings/values.dart';
import '../states/card_state.dart';
import '../../exception/app_exception.dart';
import '../states/history_point_state.dart';

class HistoryPointCubit extends Cubit<HistoryPointState> {
  final MemberRepository _repository;

  HistoryPointCubit({
    required MemberRepository repository,
  })  : _repository = repository,
        super(HistoryPointInitial()) {
    emit(HistoryPointLoading());
    _repository.getHistoryPoint(page: 1, limit: 20).then((res) {
      if (res.type == AppMessageType.success) {
        var mapEntry = res.data;
        PagingModel<HistoryPointModel>(
            limit: 20, list: mapEntry.value, maxCount: mapEntry.key, page: 1);
        emit(HistoryPointLoaded(
          paging: PagingModel<HistoryPointModel>(
            limit: 20,
            list: mapEntry.value,
            maxCount: mapEntry.key,
            page: 1,
          ),
        ));
      } else {
        emit(HistoryPointFailure(message: res.message));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  // Action data
  Future<AppMessage?> reloadHistoryPoint() async {
    var res = await _repository.getHistoryPoint(page: 1, limit: 20);

    if (res.type == AppMessageType.success) {
      var mapEntry = res.data;

      emit(HistoryPointLoaded(
        paging: PagingModel<HistoryPointModel>(
          limit: 20,
          page: 1,
          maxCount: mapEntry.key,
          list: mapEntry.value,
        ),
      ));
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> loadMore() async {
    if (this.state is! HistoryPointLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }
    var state = this.state as HistoryPointLoaded;
    if (state.paging.hasNext()) {
      var res = await _repository.getHistoryPoint(
        page: state.paging.page,
        limit: state.paging.limit,
      );
      var mapEntry = res.data;
      if (res.type == AppMessageType.success) {
        state.paging.next(mapEntry.value, mapEntry.key);
        emit(state.copyWith(paging: state.paging.copyWith()));
        return null;
      } else {
        emit(HistoryPointFailure(message: res.message));
      }
    }
    return null;
  }
}
