import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../../data/models/notify_model.dart';
import '../../../data/models/address_model.dart';
import '../../../data/models/addresses_list_model.dart';
import '../../../data/models/profile_model.dart';
import '../../../business_logic/repositories/setting_repository.dart';
import '../../../exception/app_exception.dart';
import '../../../exception/app_message.dart';

class SettingStorageRepository extends SettingRepository {

  @override
  Future<ResponseModel<bool>> changeNotify() async {
    throw UnimplementedError();
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
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> deleteAddress({
    required String id,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<AddressesListModel>> getAddresses() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<ProfileModel>> getProfile() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> updateAddress({
    required AddressModel address,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<bool>> updateProfile({
    required String lastName,
    required String firstName,
  }) async {
    throw UnimplementedError();
  }
}
