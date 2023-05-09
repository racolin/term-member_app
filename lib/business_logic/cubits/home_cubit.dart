import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/repositories/account_repository.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../data/repositories/storage/account_storage_repository.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';
import '../../presentation/res/strings/values.dart';
import '../states/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AccountRepository _repository = AccountStorageRepository();

  HomeCubit() : super(HomeInitial()) {
    emit(HomeLoading());
    _repository.isLogin().then((res) {
      if (res.type == ResponseModelType.success) {
        emit(HomeLoaded(
          type: HomeBodyType.home,
          login: res.data,
          // login: login,
        ));
      } else {
        emit(HomeFailure(message: res.message));
      }
    });
  }

  bool get login => (state is HomeLoaded && (state as HomeLoaded).login);

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  // Action data
  Future<AppMessage?> logout() async {
    try {
      await _repository.logout();
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  // Action UI
  AppMessage? setBody(HomeBodyType type) {
    if (state is! HomeLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    emit((state as HomeLoaded).copyWith(type: type));

    return null;
  }
}
