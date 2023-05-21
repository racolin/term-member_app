import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/address_model.dart';
import '../../../data/models/response_model.dart';
import '../../exception/app_message.dart';
import '../../business_logic/states/address_state.dart';
import '../../presentation/res/strings/values.dart';
import '../repositories/setting_repository.dart';

class AddressCubit extends Cubit<AddressState> {
  final SettingRepository _repository;

  AddressCubit({required SettingRepository repository})
      : _repository = repository,
        super(AddressInitial()) {
    emit(AddressLoading());
    _repository.getAddresses().then((res) {
      if (res.type == ResponseModelType.success) {
        var list = res.data;
        emit(AddressLoaded(
          defaultAddresses: list.defaults,
          otherAddresses: list.others,
        ));
      } else {
        emit(AddressFailure(message: res.message));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  Future<AppMessage?> reloadAddresses() async {
    emit(AddressLoading());
    var res = await _repository.getAddresses();
    if (res.type == ResponseModelType.success) {
      var list = res.data;
      emit(AddressLoaded(
        defaultAddresses: list.defaults,
        otherAddresses: list.others,
      ));
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> createAddress({
    required String name,
    required String address,
    required String? note,
    double? lat,
    double? lng,
    required String receiver,
    required String phone,
  }) async {
    if (state is! AddressLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var res = await _repository.createAddress(
      name: name,
      address: address,
      note: note,
      receiver: receiver,
      phone: phone,
      lat: lat,
      lng: lng,
    );

    if (res.type == ResponseModelType.success) {
      var id = res.data;
      var state = this.state as AddressLoaded;
      emit(state.copyWith(
        otherAddresses: [
              AddressModel(
                id: id,
                name: name,
                address: address,
                note: note ?? '',
                receiver: receiver,
                phone: phone,
              ),
            ] +
            state.otherAddresses,
      ));
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> deleteAddress(String id) async {
    if (state is! AddressLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var res = await _repository.deleteAddress(id: id);

    if (res.type == ResponseModelType.success) {
      if (res.data) {
        var state = this.state as AddressLoaded;
        emit(
          state.copyWith(
            otherAddresses: state.otherAddresses
                .where(
                  (e) => e.id != id,
                )
                .toList(),
          ),
        );
        return null;
      } else {
        return AppMessage(
          type: AppMessageType.failure,
          title: 'Thất bại!',
          content: 'Không thể xoá địa chỉ này!',
        );
      }
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> updateAddress(AddressModel model) async {
    if (this.state is! AddressLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }
    var state = this.state as AddressLoaded;
    var index = state.otherAddresses.indexWhere((e) => e.id == model.id);
    if (index == -1) {
      return AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi',
        content: 'Không tồn tại ID của đia chỉ này!',
      );
    }
    var res = await _repository.updateAddress(address: model);
    if (res.type == ResponseModelType.success) {
      if (res.data) {
        var list = state.otherAddresses;
        list[index] = model;

        emit(state.copyWith(otherAddresses: list));

        return null;
      } else {
        return AppMessage(
          type: AppMessageType.failure,
          title: 'Thất bại!',
          content: 'Không thể cập nhật địa chỉ này!',
        );
      }
    } else {
      return res.message;
    }
  }

  // get data method: return model if state is loaded, else return null
  List<AddressModel>? get others {
    if (state is AddressLoaded) {
      return (state as AddressLoaded).otherAddresses;
    }
    return null;
  }

  List<AddressModel>? get defaults {
    if (state is AddressLoaded) {
      return (state as AddressLoaded).defaultAddresses;
    }
    return null;
  }
}
