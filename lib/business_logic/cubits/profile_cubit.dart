import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exception/app_message.dart';
import '../../business_logic/states/profile_state.dart';
import 'package:member_app/data/models/response_model.dart';
import '../repositories/setting_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SettingRepository _repository;

  ProfileCubit({required SettingRepository repository})
      : _repository = repository,
        super(ProfileInitial()) {
    emit(ProfileLoading());

    _repository.getProfile().then((res) {
      if (res.type == ResponseModelType.success) {
        emit(ProfileLoaded(
          profile: res.data,
        ));
      } else {
        emit(ProfileFailure(message: res.message));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  Future<AppMessage?> getProfile() async {
    var res = await _repository.getProfile();
    if (res.type == ResponseModelType.success) {
      emit(ProfileLoaded(profile: res.data));
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> updateProfile({
    required String lastName,
    required String firstName,
  }) async {
      var res = await _repository.updateProfile(
        lastName: lastName,
        firstName: firstName,
      );
      if (res.type == ResponseModelType.success) {
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
        return null;
      } else {
        return res.message;
      }
  }
}
