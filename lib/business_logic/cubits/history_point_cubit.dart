import 'package:flutter_bloc/flutter_bloc.dart';

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
        emit(HistoryPointLoaded(
          list: mapEntry.value,
          maxCount: mapEntry.key,
          page: 1,
        ));
      });
    } on AppException catch (ex) {
      emit(HistoryPointFailure(message: ex.message));
    }
  }

  // Action data
  Future<AppMessage?> reloadHistoryPoint() async {
    try {
      _repository.getHistoryPoint(page: 1, limit: 20).then((mapEntry) {
        emit(HistoryPointLoaded(
          list: mapEntry.value,
          maxCount: mapEntry.key,
          page: 1,
        ));
      });
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<AppMessage?> loadMore() async {
    if (this.state is! HistoryPointLoaded) {
      return AppMessage(messageType: AppMessageType.failure, title: 'Đợi', content: 'Hãy đợi load xong!');
    }
    var state =  this.state as HistoryPointLoaded;
    if (state.limit * state.page >= state.maxCount) {
      return null;
    }
    try {
      _repository.getHistoryPoint(page: state.page + 1, limit: state.limit).then((mapEntry) {
        emit(HistoryPointLoaded(
          list: state.list + mapEntry.value,
          maxCount: mapEntry.key,
          page: state.page + 1,
        ));
      });
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }
}
