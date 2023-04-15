import '../../data/models/address_model.dart';
import '../../data/models/addresses_list_model.dart';
import '../../data/models/profile_model.dart';

abstract class SettingRepository {
  Future<ProfileModel?> getProfile();

  Future<bool?> updateProfile({
    required String lastName,
    required String firstName,
  });

  Future<AddressesListModel> getAddresses();

  Future<String?> createAddress({
    required String name,
    required String address,
    required String note,
    double? lat,
    double? lng,
    required String receiver,
    required String phone,
  });

  Future<bool?> updateAddress({
    required AddressModel address,
  });

  Future<bool?> deleteAddress({
    required String id,
  });

  Future<bool?> changeNotify();
}
