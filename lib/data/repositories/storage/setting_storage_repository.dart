import 'package:google_maps_webservice/places.dart';
import 'package:member_app/business_logic/cubits/address_cubit.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../../data/models/address_model.dart';
import '../../../data/models/addresses_list_model.dart';
import '../../../data/models/profile_model.dart';
import '../../../business_logic/repositories/setting_repository.dart';

class SettingStorageRepository extends SettingRepository {

  @override
  Future<ResponseModel<bool>> changeNotify() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<String>> createAddress({
    required String name,
    required String address,
    String? note,
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

  @override
  Future<ResponseModel<List<AddressEntity>>> searchAddressesByLocation({required Location location, required double radius}) {
    // TODO: implement searchAddressesByLocation
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<AddressEntity>> searchPlaceById({required String id}) {
    // TODO: implement searchPlaceById
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<AddressEntity>>> searchAddressesByText({required String address, Location? origin}) {
    // TODO: implement searchAddressesByText
    throw UnimplementedError();
  }
}
