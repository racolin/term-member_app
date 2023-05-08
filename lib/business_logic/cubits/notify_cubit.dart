import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';
import '../repositories/notify_repository.dart';
import '../states/notify_state.dart';

class NotifyCubit extends Cubit<NotifyState> {
  final NotifyRepository _repository;

  NotifyCubit({required NotifyRepository repository})
      : _repository = repository,
        super(NotifyInitial()) {
    emit(NotifyLoading());
    _repository.gets().then((res) {
      if (res.type == ResponseModelType.success) {
        emit(NotifyLoaded(list: res.data));
      } else {
        emit(NotifyFailure(message: res.message));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  // Action data
  Future<AppMessage?> reloadNotify() async {
    var res = await _repository.gets();
    if (res.type == ResponseModelType.success) {
      emit(NotifyLoaded(list: res.data));
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> check(String id) async {
    var res = await _repository.checkNotify(id: id);
    if (res.type == ResponseModelType.success) {
      if (res.data) {
        var list = (state as NotifyLoaded).list;
        var index = list.indexWhere((e) => e.id == id);
        if (index != -1) {
          emit(NotifyLoaded(list: list));
          return null;
        }
      }
      return null;
    } else {
      return res.message;
    }
  }
}
