import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/response_model.dart';
import '../../exception/app_message.dart';
import '../../presentation/res/strings/values.dart';
import '../repositories/auth_repository.dart';
import '../states/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit({required AuthRepository repository})
      : _repository = repository,
        super(AuthInitial());

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  Future<AppMessage?> login(String phone) async {
    phone = '+84$phone';
    var res = await _repository.login(phone: phone);
    if (res.type == ResponseModelType.success) {
      if (res.data) {
        emit(AuthLogin(phone: phone));
        return null;
      } else {
        return AppMessage(
          type: AppMessageType.error,
          title: txtFailureTitle,
          content: 'Số điện thoại không đúng!',
        );
      }
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> register({
    required String phone,
    required DateTime dob,
    required String firstName,
    required String lastName,
    required int gender,
  }) async {
    phone = '+84$phone';
    var res = await _repository.register(
      phone: phone,
      dob: dob.millisecondsSinceEpoch,
      firstName: firstName,
      gender: gender,
      lastName: lastName,
    );
    if (res.type == ResponseModelType.success) {
      if (res.data) {
        emit(AuthLogin(phone: phone));
        return null;
      } else {
        return AppMessage(
          type: AppMessageType.error,
          title: 'Có lỗi!',
          content: 'Không thể đăng ký. Hãy thử lại!',
        );
      }
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> otpCheck(String otp) async {
    if (state is! AuthLogin) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var res = await _repository.otpCheck(
      phone: (state as AuthLogin).phone,
      otp: otp,
    );
    if (res.type == ResponseModelType.success) {
      if (res.data) {
        return null;
      } else {
        return AppMessage(
          type: AppMessageType.error,
          title: 'Có lỗi!',
          content: 'Không kiểm tra được mã otp.',
        );
      }
    } else {
      return res.message;
    }
  }

// get data method: return model if state is loaded, else return null
}
