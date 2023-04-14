import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/repositories/member_repository.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';
import '../../data/models/app_bar_model.dart';
import '../states/app_bar_state.dart';

class AppBarCubit extends Cubit<AppBarState> {
  final MemberRepository _repository;

  AppBarCubit({required MemberRepository repository})
      : _repository = repository,
        super(AppBarInitial());

  // Action data
  Future<AppMessage?> loadAppBar() async {
    emit(AppBarLoading());

    try {
      var appBar = await _repository.getAppBar();

      appBar ??= const AppBarModel(
        greeting: 'Xin chào!',
        templateCartAmount: 0,
        voucherAmount: 0,
        notifyAmount: 0,
      );

      emit(AppBarLoaded(appBar: appBar));
    } on AppException catch (ex) {
      return ex.message;
    }

    return null;
  }
}
