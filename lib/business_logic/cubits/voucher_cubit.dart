import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exception/app_message.dart';
import '../../business_logic/states/voucher_state.dart';
import '../../exception/app_exception.dart';
import '../repositories/voucher_repository.dart';

class VoucherCubit extends Cubit<VoucherState> {
  final VoucherRepository _repository;

  VoucherCubit({required VoucherRepository repository})
      : _repository = repository,
        super(VoucherInitial()) {
    emit(VoucherLoading());
    try {
      print('1213131313');
      _repository.getsAvailable().then((list) {
        if (state is VoucherLoaded) {
          emit((state as VoucherLoaded).copyWith(list: list));
        } else {
          emit(VoucherLoaded(
            list: list,
          ));
        }
      });
      _repository.getsUsed().then((list) {
        if (state is VoucherLoaded) {
          emit((state as VoucherLoaded).copyWith(used: list));
        } else {
          emit(VoucherLoaded(
            used: list,
            list: const [],
          ));
        }
      });
    } on AppException catch (ex) {}
  }

  Future<AppMessage?> reloadVouchers() async {
    try {
      var list = await _repository.getsAvailable();
      if (state is VoucherLoaded) {
        emit((state as VoucherLoaded).copyWith(list: list));
      } else {
        emit(VoucherLoaded(
          list: list,
        ));
      }
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<AppMessage?> getUsedVouchers() async {
    try {
      var list = await _repository.getsUsed();
      if (state is VoucherLoaded) {
        emit((state as VoucherLoaded).copyWith(used: list));
      } else {
        emit(VoucherLoaded(
          used: list,
          list: const [],
        ));
      }
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  void clearUsedVouchers() {
    if (state is VoucherLoaded) {
      emit((state as VoucherLoaded).copyWith(used: []));
    }
  }
}
