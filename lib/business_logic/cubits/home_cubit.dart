import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exception/app_exception.dart';
import '../../data/repositories/logout_storage_repository.dart';
import '../../exception/app_message.dart';
import '../states/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _repository = LogoutStorageRepository();

  HomeCubit(bool login) : super(HomeInitial()) {
    emit(HomeLoading());
    _repository.isLogin().then((login) {
      emit(HomeLoaded(
        type: HomeBodyType.home,
        login: login,
      ));
    });
  }

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
