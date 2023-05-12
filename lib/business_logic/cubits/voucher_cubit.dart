import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../exception/app_message.dart';
import '../../business_logic/states/voucher_state.dart';
import '../../presentation/res/strings/values.dart';
import '../repositories/voucher_repository.dart';

class VoucherCubit extends Cubit<VoucherState> {
  final VoucherRepository _repository;

  VoucherCubit({required VoucherRepository repository})
      : _repository = repository,
        super(VoucherInitial()) {
    emit(VoucherLoading());
    var failure = 0;
    var error = {};
    _repository.getsAvailable().then((res) {
      if (res.type == ResponseModelType.success) {
        if (state is VoucherLoaded) {
          emit((state as VoucherLoaded).copyWith(
            list: res.data,
          ));
        } else {
          emit(VoucherLoaded(
            list: res.data,
          ));
        }
      } else {
        failure++;
        error['available'] = res.message.toString();
        if (failure == 2) {
          emit(
            VoucherFailure(
              message: AppMessage(
                type: AppMessageType.error,
                title: txtErrorTitle,
                content: 'Có lỗi đã xảy ra khi tải voucher. Hãy thử lại!',
                description: error.toString(),
              ),
            ),
          );
        }
      }
    });
    _repository.getsUsed().then((res) {
      if (res.type == ResponseModelType.success) {
        if (state is VoucherLoaded) {
          emit((state as VoucherLoaded).copyWith(
            used: res.data,
          ));
        } else {
          emit(VoucherLoaded(
            used: res.data,
            list: const [],
          ));
        }
      } else {
        failure++;
        error['used'] = res.message.toString();
        if (failure == 2) {
          emit(
            VoucherFailure(
              message: AppMessage(
                type: AppMessageType.error,
                title: txtErrorTitle,
                content: 'Có lỗi đã xảy ra khi tải voucher. Hãy thử lại!',
                description: error.toString(),
              ),
            ),
          );
        }
      }
    });
  }

// base method: return response model, use to avoid repeat code.

// action method, change state and return AppMessage?, null when success

// get data method: return model if state is loaded, else return null

  Future<AppMessage?> loadAvailableVouchers() async {
    var res = await _repository.getsAvailable();
    if (res.type == ResponseModelType.success) {
      if (state is VoucherLoaded) {
        emit((state as VoucherLoaded).copyWith(list: res.data));
      } else {
        emit(VoucherLoaded(
          list: res.data,
        ));
      }
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> loadUsedVouchers() async {
    var res = await _repository.getsUsed();
    if (res.type == ResponseModelType.success) {
      if (state is VoucherLoaded) {
        emit((state as VoucherLoaded).copyWith(used: res.data));
      } else {
        emit(VoucherLoaded(
          used: res.data,
          list: const [],
        ));
      }
      return null;
    } else {
      return res.message;
    }
  }

  void clearUsedVouchers() {
    if (state is VoucherLoaded) {
      emit((state as VoucherLoaded).copyWith(used: []));
    }
  }
}
