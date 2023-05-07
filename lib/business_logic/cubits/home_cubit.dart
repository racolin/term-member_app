import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/repositories/account_repository.dart';

import '../../data/repositories/storage/account_storage_repository.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';
import '../states/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AccountRepository _repository = AccountStorageRepository();

  HomeCubit(bool login) : super(HomeInitial()) {
    emit(HomeLoading());
    _repository.isLogin().then((login) {
      emit(HomeLoaded(
        type: HomeBodyType.home,
        login: true,
        // login: login,
      ));
    });
  }

  bool get login => (state is HomeLoaded && (state as HomeLoaded).login);

  // base method: return response model, use to avoid repeat code.

  // api method

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
  AppException? setBody(HomeBodyType type) {
    if (state is! HomeLoaded) {
      return AppException(
        message: AppMessage(
          type: AppMessageType.failure,
          title: 'Đợi',
          content: 'Thao tác chưa được xửt lý vì quá nhanh.',
        ),
      );
    }

    emit((state as HomeLoaded).copyWith(
      type: type,
    ));

    return null;
  }
}
