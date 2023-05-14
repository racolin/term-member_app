import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../../business_logic/repositories/member_repository.dart';
import '../../data/models/app_bar_model.dart';
import '../../data/repositories/storage/account_storage_repository.dart';
import '../../exception/app_message.dart';
import '../../presentation/res/strings/values.dart';
import '../repositories/account_repository.dart';
import '../states/app_bar_state.dart';

class AppBarCubit extends Cubit<AppBarState> {
  final AccountRepository _accountRepository = AccountStorageRepository();
  final MemberRepository _repository;

  AppBarCubit({
    required MemberRepository repository,
  })  : _repository = repository,
        super(AppBarInitial()) {
    emit(AppBarLoading());
    var model = const AppBarModel(
      greeting: 'Xin chào!',
      cartTemplateAmount: 0,
      voucherAmount: 0,
      notifyAmount: 0,
    );
    _accountRepository.isLogin().then((res) {
      if (res.type == ResponseModelType.success) {
        if (res.data) {
          _repository.getAppBar().then((res) {
            if (res.type == ResponseModelType.success) {
              emit(AppBarLoaded(appBar: res.data));
            } else {
              emit(AppBarLoaded(appBar: model));
              // emit(AppBarFailure(message: res.message));
            }
          });
        } else {
          emit(AppBarLoaded(appBar: model));
        }
      } else {
        emit(AppBarLoaded(appBar: model));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  Future<AppMessage?> reloadAppBar() async {
    if (state is! AppBarLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var res = await _repository.getAppBar();

    if (res.type == ResponseModelType.success) {
      emit(AppBarLoaded(appBar: res.data));
      return null;
    } else {
      return res.message;
    }
  }

  // get data method: return model if state is loaded, else return null

  AppBarModel? get appBar {
    if (state is AppBarLoaded) {
      return (state as AppBarLoaded).appBar;
    }
    return null;
  }
}
