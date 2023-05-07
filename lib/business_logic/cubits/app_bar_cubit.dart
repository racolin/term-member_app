import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/repositories/member_repository.dart';

import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';
import '../../data/models/app_bar_model.dart';
import '../states/app_bar_state.dart';

class AppBarCubit extends Cubit<AppBarState> {
  final MemberRepository _repository;

  AppBarCubit({required MemberRepository repository})
      : _repository = repository,
        super(AppBarInitial()) {
    emit(AppBarLoading());
    var model = const AppBarModel(
      greeting: 'Xin chào!',
      cartTemplateAmount: 0,
      voucherAmount: 0,
      notifyAmount: 0,
    );
    try {
      _repository.getAppBar().then((appBar) {
        appBar ??= model;
        emit(AppBarLoaded(appBar: appBar));
      });
    } on AppException catch (ex) {
      emit(AppBarLoaded(appBar: model));
    }
  }


  // base method: return response model, use to avoid repeat code.

  // api method

  // get data method: return model if state is loaded, else return null
  Future<>

  Future<AppMessage?> reloadAppBar() async {
    try {
      var appBar = await _repository.getAppBar();

      appBar ??= const AppBarModel(
        greeting: 'Xin chào!',
        cartTemplateAmount: 0,
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
