import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/exception/app_exception.dart';

import '../../data/models/response_model.dart';
import '../../exception/app_message.dart';
import '../repositories/auth_repository.dart';
import '../states/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit({required AuthRepository repository})
      : _repository = repository,
        super(AuthInitial());

  // base method: return response model, use to avoid repeat code.

  // api method

  // get data method: return model if state is loaded, else return null

  // Action data
  Future<AppMessage?> login(String phone) async {
    try {
      ResponseModel<bool> result = await _repository.login(phone: phone);
      if (result.type == ResponseModelType.failure) {
        return result.message;
      } else if (result.data) {

      } else {

      }
      if (result == null) {
        return AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi',
          content: 'Không thể đăng nhâp. Hãy thử lại!',
        );
      } else if (result) {
        emit(AuthLogin(phone: phone));
      } else {
        return AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi',
          content: 'Số điện thoại không đúng!',
        );
      }
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<AppMessage?> register({
    required String phone,
    required DateTime dob,
    required String firstName,
    required String lastName,
    required int gender,
  }) async {
    try {
      bool? result = await _repository.register(
        phone: phone,
        dob: dob.millisecondsSinceEpoch,
        firstName: firstName,
        gender: gender,
        lastName: lastName,
      );
      if (result == null) {
        return AppMessage(
          type: AppMessageType.error,
          title: 'Trục trặc',
          content: 'Không thể đăng ký. Hãy thử lại!',
        );
      } else if (result) {
        emit(AuthLogin(phone: phone));
      } else {
        return AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi',
          content: 'Không thể đăng ký. Hãy thử lại!',
        );
      }
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<AppMessage?> otpCheck(String otp) async {
    if (state is! AuthLogin) {
      return AppMessage(
        type: AppMessageType.info,
        title: 'Thông báo',
        content: 'Giao diện chưa tải xong!',
      );
    }
    try {
      bool? result = await _repository.otpCheck(
        phone: (state as AuthLogin).phone, otp: otp,
      );
      if (result == null) {
        return AppMessage(
          type: AppMessageType.failure,
          title: 'Trục trặc',
          content: 'Không thể kiểm tra OTP. Hãy thử lại!',
        );
      } else if (result) {
        return null;
      } else {
        return AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi',
          content: 'Không thể đăng ký. Hãy thử lại!',
        );
      }
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }
}
