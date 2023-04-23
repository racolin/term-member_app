import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exception/app_message.dart';
import '../../business_logic/states/profile_state.dart';
import '../../exception/app_exception.dart';
import '../repositories/setting_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SettingRepository _repository;

  ProfileCubit({required SettingRepository repository})
      : _repository = repository,
        super(ProfileInitial()) {
    emit(ProfileLoading());

    try {
      _repository.getProfile().then((profile) {
        if (profile != null) {
          emit(ProfileLoaded(
            profile: profile,
          ));
        }
      });
    } on AppException catch (ex) {
      emit(ProfileFailure(message: ex.message));
    }
    emit(
      ProfileFailure(
        message: AppMessage(
            type: AppMessageType.failure,
            title: 'Thất bại',
            content: 'Tải Profile không thành công!'),
      ),
    );
  }

  Future<AppMessage?> getProfile() async {
    try {
      var profile = await _repository.getProfile();
      if (profile == null) {
        return AppMessage(
          type: AppMessageType.failure,
          title: 'Thất bại',
          content: 'Tải Profile không thành công!',
        );
      }
      if (state is ProfileLoaded) {
        emit((state as ProfileLoaded).copyWith(profile: profile));
      }
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<AppMessage?> updateProfile({
    required String lastName,
    required String firstName,
  }) async {
    try {
      var result = await _repository.updateProfile(
        lastName: lastName,
        firstName: firstName,
      );
      if (result == null || !result) {
        return AppMessage(
          type: AppMessageType.failure,
          title: 'Thất bại',
          content: 'Cập nhật Profile không thành công!',
        );
      }
      if (state is ProfileLoaded) {
        var state = this.state as ProfileLoaded;
        emit(
          state.copyWith(
            profile: state.profile.copyWith(
              lastName: lastName,
              firstName: firstName,
            ),
          ),
        );
      }
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }
}
