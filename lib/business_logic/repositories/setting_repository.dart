import '../../data/models/address_model.dart';
import '../../data/models/addresses_list_model.dart';
import '../../data/models/profile_model.dart';
import '../../data/models/response_model.dart';

abstract class SettingRepository {
  Future<ResponseModel<ProfileModel>> getProfile();

  Future<ResponseModel<bool>> updateProfile({
    required String lastName,
    required String firstName,
  });

  Future<ResponseModel<AddressesListModel>> getAddresses();

  Future<ResponseModel<String>> createAddress({
    required String name,
    required String address,
    String? note,
    double? lat,
    double? lng,
    required String receiver,
    required String phone,
  });

  Future<ResponseModel<bool>> updateAddress({
    required AddressModel address,
  });

  Future<ResponseModel<bool>> deleteAddress({
    required String id,
  });

  Future<ResponseModel<bool>> changeNotify();
}
