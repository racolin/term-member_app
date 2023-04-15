import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/notify_api_repository.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';
import '../states/notify_state.dart';

class NotifyCubit extends Cubit<NotifyState> {
  final _repository = NotifyApiRepository();

  NotifyCubit() : super(NotifyInitial()) {
    emit(NotifyLoading());
    try {
      _repository.gets().then((list) {
        emit(NotifyLoaded(list: list));
      });
    } on AppException catch (ex) {
      emit(NotifyFailure(message: ex.message));
    }
  }

  // Action data
  Future<AppMessage?> reloadNotify() async {
    try {
      var list = await _repository.gets();
      emit(NotifyLoaded(list: list));
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<AppMessage?> check(String id) async {
    bool? check = await _repository.checkNotify(id: id);
    if (check != null && check) {
      var list = (state as NotifyLoaded).list;
      var index = list.indexWhere((e) => e.id == id);
      if (index != -1) {
        emit(NotifyLoaded(list: list));
        return null;
      }
    }
    return AppMessage(
      messageType: AppMessageType.error,
      title: 'Lỗi!',
      content: 'Không thể tích thông báo',
    );
  }
}
