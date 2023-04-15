import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/address_model.dart';

import '../../exception/app_message.dart';
import '../../business_logic/states/address_state.dart';
import '../../exception/app_exception.dart';
import '../repositories/setting_repository.dart';

class AddressCubit extends Cubit<AddressState> {
  final SettingRepository _repository;

  AddressCubit({required SettingRepository repository})
      : _repository = repository,
        super(AddressInitial()) {
    try {
      _repository.getAddresses().then((list) {
        emit(AddressLoaded(
          defaultAddresses: list.defaults,
          otherAddresses: list.others,
        ));
      });
    } on AppException catch (ex) {}
  }

  Future<AppMessage?> getAddresses() async {
    try {
      var list = await _repository.getAddresses();
      emit(AddressLoaded(
        defaultAddresses: list.defaults,
        otherAddresses: list.others,
      ));
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<AppMessage?> createAddress({
    required String name,
    required String address,
    required String note,
    double? lat,
    double? lng,
    required String receiver,
    required String phone,
  }) async {
    if (state is! AddressLoaded) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Thất bại',
        content: 'Hãy thử lại trong giây lát!',
      );
    }

    try {
      String? id = await _repository.createAddress(
        name: name,
        address: address,
        note: note,
        receiver: receiver,
        phone: phone,
        lat: lat,
        lng: lng,
      );

      if (id == null) {
        return AppMessage(
          messageType: AppMessageType.failure,
          title: 'Thất bại',
          content: 'Không thể tạo địa chỉ mới. Hãy thử lại!',
        );
      }
      var state = this.state as AddressLoaded;
      emit(state.copyWith(
        otherAddresses: state.otherAddresses +
            [
              AddressModel(
                id: id,
                name: name,
                address: address,
                note: note,
                receiver: receiver,
                phone: phone,
              ),
            ],
      ));
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<AppMessage?> deleteAddress(String id) async {
    if (state is! AddressLoaded) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Thất bại',
        content: 'Hãy thử lại trong giây lát!',
      );
    }

    try {
      bool? result = await _repository.deleteAddress(id: id);

      if (result == null || !result) {
        return AppMessage(
          messageType: AppMessageType.failure,
          title: 'Thất bại',
          content: 'Không thể xoá địa chỉ. Hãy thử lại!',
        );
      }
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
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<AppMessage?> updateAddress(AddressModel model) async {
    try {
      var state = this.state as AddressLoaded;
      var index = state.otherAddresses.indexWhere((e) => e.id == model.id);
      if (index == -1) {
        return AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi',
          content: 'Không tồn tại ID của đia chỉ này!',
        );
      }
      bool? result = await _repository.updateAddress(address: model);

      if (result == null || !result) {
        return AppMessage(
          messageType: AppMessageType.failure,
          title: 'Không thành công',
          content: 'Không cập nhật được địa chỉ!',
        );
      }

      var list = state.otherAddresses;
      list[index] = model;

      emit(state.copyWith(otherAddresses: list));
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }
}
