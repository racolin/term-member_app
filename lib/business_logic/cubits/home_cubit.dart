import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exception/app_exception.dart';
import '../../data/repositories/logout_storage_repository.dart';
import '../../exception/app_message.dart';
import '../states/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _repository = LogoutStorageRepository();

  HomeCubit({required bool login})
      : super(
          HomeState(
            homeBodyType: HomeBodyType.home,
            login: login,
          ),
        );

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
  void setBody(HomeBodyType type) {
    emit(state.copyWith(
      homeBodyType: type,
    ));
  }
}
