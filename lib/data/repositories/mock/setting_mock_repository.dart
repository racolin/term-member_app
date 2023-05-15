import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../models/address_model.dart';
import '../../models/addresses_list_model.dart';
import '../../models/profile_model.dart';
import '../../../business_logic/repositories/setting_repository.dart';
import '../../../exception/app_message.dart';

class SettingMockRepository extends SettingRepository {
  // var _notifies = List.generate(
  //   20,
  //   (index) => NotifyModel(
  //     id: 'NOTIFY-$index',
  //     type: 2,
  //     targetId: 'VOUCHER-1',
  //     name: 'Một bước lên "mây" khum khó!',
  //     description: [
  //       'Nhà mới Cà phê 19k/The Coffee House sữa đá 29k/Trà trái cây, CloudFee 39K khi mua cùng bánh bất kỳ (trừ bánh mì que)',
  //       '- Áp dụng cho size M',
  //       '- Nhập mã: TUYETVOI'
  //           '',
  //       '=> Chọn món bạn thích, Nhà giao ngay!'
  //     ].join('|'),
  //     image:
  //         'https://img.freepik.com/free-vector/brown-sugar-bubble-milk-tea-set-promotion-free-flyer-template-watercolor-illustration_83728-563.jpg',
  //     time: DateTime.now(),
  //     checked: false,
  //   ),
  // );

  var _defaults = [
    AddressModel(
      id: 'ADDRESS-HOME',
      icon: 'Icons.home_outlined.codePoint',
      name: 'Địa chỉ phòng trọ',
      address: '125/42/14 Bùi Đình Tuý, Bình Thạnh, TP.Hồ Chí Minh',
      note: 'Cái nhà có cổng màu đen',
      receiver: 'Phan Trung Tín',
      phone: '0868754872',
    ),
    AddressModel(
      id: 'ADDRESS-WORK',
      name: 'Địa chỉ nơi làm việc',
      icon: 'Icons.domain_outlined.codePoint',
      address: '419 Ngô Gia Tự, Quận 10, TP.Hồ Chí Minh',
      note: 'Toà nhà kế bên tiệm kính chứ không ohair tiệm kính',
      receiver: 'Phan Trung Tín',
      phone: '0868754872',
    ),
  ];

  var othersCount = 2;

  var _others = [
    AddressModel(
      id: 'OTHER-1',
      name: 'KTX',
      address: 'KTX khu B, đại học quốc gia TP.Hồ Chí Minh',
      note: 'Cổng sau của KTX',
      receiver: 'Phin Trung Tán',
      phone: '0868754872',
    ),
  ];

  var _profile = ProfileModel(
    firstName: 'Phan',
    lastName: 'Tín',
    dob: DateTime(2001, 5, 11),
    gender: 0,
    phone: '0868754872',
  );

  @override
  Future<ResponseModel<bool>> changeNotify() async {
    return ResponseModel<bool>(
      type: ResponseModelType.success,
      data: true,
    );
    return ResponseModel<bool>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi chuyển sang đã đọc',
      ),
    );
  }

  @override
  Future<ResponseModel<String>> createAddress({
    required String name,
    required String address,
    required String note,
    double? lat,
    double? lng,
    required String receiver,
    required String phone,
  }) async {
    _others.add(
      AddressModel(
        id: 'OTHER-$othersCount',
        name: name,
        address: address,
        lat: lat,
        lng: lng,
        note: note,
        receiver: receiver,
        phone: phone,
      ),
    );
    othersCount++;
    return ResponseModel<String>(
      type: ResponseModelType.success,
      data: 'ADDRESS-NEW',
    );
    return ResponseModel<String>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi tạo địa chỉ',
      ),
    );
  }

  @override
  Future<ResponseModel<bool>> deleteAddress({
    required String id,
  }) async {
    _others.removeWhere((e) => e.id == id);
    return ResponseModel<bool>(
      type: ResponseModelType.success,
      data: true,
    );
    return ResponseModel<bool>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi xoá địa chỉ',
      ),
    );
  }

  @override
  Future<ResponseModel<AddressesListModel>> getAddresses() async {
    return ResponseModel<AddressesListModel>(
      type: ResponseModelType.success,
      data: AddressesListModel(
        defaults: _defaults,
        others: _others,
      ),
    );
    return ResponseModel<AddressesListModel>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi chuyển sang đã đọc',
      ),
    );
  }

  @override
  Future<ResponseModel<ProfileModel>> getProfile() async {
    return ResponseModel<ProfileModel>(
      type: ResponseModelType.success,
      data: _profile,
    );
    return ResponseModel<ProfileModel>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi lấy profile',
      ),
    );
  }

  @override
  Future<ResponseModel<bool>> updateAddress({
    required AddressModel address,
  }) async {
    var list = _defaults + _others;
    int index = list.indexWhere((e) => e.id == address.id);
    if (index == -1) {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Không tìm thấy mã địa chỉ',
        ),
      );
    }
    if (index >= _defaults.length) {
      _others[_defaults.length - index] = AddressModel(
        id: address.id,
        name: address.name,
        address: address.address,
        note: address.note,
        receiver: address.receiver,
        phone: address.phone,
        lat: address.lat,
        lng: address.lng,
      );
    } else {
      _defaults[index] = AddressModel(
        id: address.id,
        name: address.name,
        address: address.address,
        note: address.note,
        receiver: address.receiver,
        phone: address.phone,
        lat: address.lat,
        lng: address.lng,
      );
    }
    return ResponseModel<bool>(
      type: ResponseModelType.success,
      data: true,
    );
    return ResponseModel<bool>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi sửa địa chỉ',
      ),
    );
    return ResponseModel<bool>(
      type: ResponseModelType.success,
      data: false,
    );
  }

  @override
  Future<ResponseModel<bool>> updateProfile({
    required String lastName,
    required String firstName,
  }) async {
    _profile = ProfileModel(
      firstName: firstName,
      lastName: lastName,
      dob: _profile.dob,
      gender: _profile.gender,
      phone: _profile.phone,
    );
    return ResponseModel<bool>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi sửa profile',
      ),
    );
    return ResponseModel<bool>(
      type: ResponseModelType.success,
      data: true,
    );
  }
}
