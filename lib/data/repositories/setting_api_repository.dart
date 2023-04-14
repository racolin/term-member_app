import '../../data/models/address_model.dart';
import '../../data/models/addresses_list_model.dart';
import '../../data/models/profile_model.dart';
import '../../business_logic/repositories/setting_repository.dart';

class SettingApiRepository extends SettingRepository {
  @override
  Future<bool?> changeNotify() {
    // TODO: implement changeNotify
    throw UnimplementedError();
  }

  @override
  Future<bool?> createAddress({
    required String id,
    required String name,
    required String address,
    required String note,
    double? lat,
    double? lng,
    required String receiver,
    required String phone,
  }) {
    // TODO: implement createAddress
    throw UnimplementedError();
  }

  @override
  Future<bool?> deleteAddress({required String id}) {
    // TODO: implement deleteAddress
    throw UnimplementedError();
  }

  @override
  Future<AddressesListModel?> getAddresses() {
    // TODO: implement getAddresses
    throw UnimplementedError();
  }

  @override
  Future<ProfileModel?> getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future<bool?> updateAddress({required AddressModel address}) {
    // TODO: implement updateAddress
    throw UnimplementedError();
  }

  @override
  Future<bool?> updateProfile(
      {required String lastName, required String firstName}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
