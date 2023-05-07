import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/history_point_model.dart';
import 'package:member_app/data/models/paging_model.dart';

import '../../business_logic/repositories/member_repository.dart';
import '../../exception/app_message.dart';
import '../states/card_state.dart';
import '../../exception/app_exception.dart';
import '../states/history_point_state.dart';

class HistoryPointCubit extends Cubit<HistoryPointState> {
  final MemberRepository _repository;

  HistoryPointCubit({
    required MemberRepository repository,
  })  : _repository = repository,
        super(HistoryPointInitial()) {
    try {
      _repository.getHistoryPoint(page: 1, limit: 20).then((mapEntry) {
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
      });
    } on AppException catch (ex) {
      emit(HistoryPointFailure(message: ex.message));
    }
  }

  // base method: return response model, use to avoid repeat code.

  // api method

  // get data method: return model if state is loaded, else return null

  // Action data
  Future<AppMessage?> reloadHistoryPoint() async {
    try {
      var mapEntry = await _repository.getHistoryPoint(page: 1, limit: 20);

      emit(HistoryPointLoaded(
        paging: PagingModel<HistoryPointModel>(
          limit: 20,
          page: 1,
          maxCount: mapEntry.key,
          list: mapEntry.value,
        ),
      ));
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<AppMessage?> loadMore() async {
    if (this.state is! HistoryPointLoaded) {
      return AppMessage(
          type: AppMessageType.failure,
          title: 'Đợi',
          content: 'Hãy đợi load xong!');
    }
    var state = this.state as HistoryPointLoaded;
    if (state.paging.hasNext()) {
      try {
        _repository
            .getHistoryPoint(
          page: state.paging.page,
          limit: state.paging.limit,
        )
            .then((mapEntry) {
          state.paging.next(mapEntry.value, mapEntry.key);
          emit(state.copyWith(paging: state.paging.copyWith()));
        });
      } on AppException catch (ex) {
        return ex.message;
      }
      return null;
    }
  }
}
