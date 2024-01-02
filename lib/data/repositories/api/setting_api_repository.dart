import 'package:dio/dio.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:member_app/business_logic/cubits/address_cubit.dart';

import '../../models/response_model.dart';
import '../../services/api_client.dart';
import '../../../presentation/res/strings/values.dart';
import '../../models/address_model.dart';
import '../../models/addresses_list_model.dart';
import '../../models/profile_model.dart';
import '../../../business_logic/repositories/setting_repository.dart';
import '../../../exception/app_message.dart';
import '../../models/raw_failure_model.dart';
import '../../models/raw_success_model.dart';
import '../../services/api_config.dart';

class SettingApiRepository extends SettingRepository {
  final _dio = ApiClient.dioAuth;

  @override
  Future<ResponseModel<bool>> changeNotify() async {
    try {
      var res = await _dio.patch(
        ApiRouter.settingNotification,
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: raw.success ?? false,
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<bool>(
          type: ResponseModelType.failure,
          message: ex.error,
        );
      } else {
        var raw = RawFailureModel.fromMap(
          ex.response?.data ??
              {
                'statusCode': 444,
                'message': 'Không có dữ liệu trả về!',
              },
        );
        return ResponseModel<bool>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
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
    try {
      var res = await _dio.post(
        ApiRouter.settingAddress,
        data: {
          'name': name,
          'address': address,
          'note': note,
          'lat': lat ?? 0,
          'lng': lng ?? 0,
          'receiver': receiver,
          'phone': phone,
        },
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<String>(
        type: ResponseModelType.success,
        data: raw.data['id'],
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<String>(
          type: ResponseModelType.failure,
          message: ex.error,
        );
      } else {
        var raw = RawFailureModel.fromMap(
          ex.response?.data ??
              {
                'statusCode': 444,
                'message': 'Không có dữ liệu trả về!',
              },
        );
        return ResponseModel<String>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<String>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }

  @override
  Future<ResponseModel<bool>> deleteAddress({
    required String id,
  }) async {
    try {
      var res = await _dio.delete(
        ApiRouter.settingAddressDelete(id),
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: raw.success ?? false,
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<bool>(
          type: ResponseModelType.failure,
          message: ex.error,
        );
      } else {
        var raw = RawFailureModel.fromMap(
          ex.response?.data ??
              {
                'statusCode': 444,
                'message': 'Không có dữ liệu trả về!',
              },
        );
        return ResponseModel<bool>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }

  @override
  Future<ResponseModel<AddressesListModel>> getAddresses() async {
    try {
      var res = await _dio.get(
        ApiRouter.settingAddress,
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<AddressesListModel>(
        type: ResponseModelType.success,
        data: AddressesListModel.fromMap(raw.data),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<AddressesListModel>(
          type: ResponseModelType.failure,
          message: ex.error,
        );
      } else {
        var raw = RawFailureModel.fromMap(
          ex.response?.data ??
              {
                'statusCode': 444,
                'message': 'Không có dữ liệu trả về!',
              },
        );
        return ResponseModel<AddressesListModel>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<AddressesListModel>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }

  @override
  Future<ResponseModel<ProfileModel>> getProfile() async {
    try {
      var res = await _dio.get(
        ApiRouter.settingProfile,
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<ProfileModel>(
        type: ResponseModelType.success,
        data: ProfileModel.fromMap(raw.data),
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<ProfileModel>(
          type: ResponseModelType.failure,
          message: ex.error,
        );
      } else {
        var raw = RawFailureModel.fromMap(
          ex.response?.data ??
              {
                'statusCode': 444,
                'message': 'Không có dữ liệu trả về!',
              },
        );
        return ResponseModel<ProfileModel>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<ProfileModel>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }

  @override
  Future<ResponseModel<bool>> updateAddress({
    required AddressModel address,
  }) async {
    try {
      var res = await _dio.put(
        ApiRouter.settingAddressUpdate(address.id),
        data: address.toMap(),
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: raw.success ?? false,
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<bool>(
          type: ResponseModelType.failure,
          message: ex.error,
        );
      } else {
        var raw = RawFailureModel.fromMap(
          ex.response?.data ??
              {
                'statusCode': 444,
                'message': 'Không có dữ liệu trả về!',
              },
        );
        return ResponseModel<bool>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }

  @override
  Future<ResponseModel<bool>> updateProfile({
    required String lastName,
    required String firstName,
  }) async {
    try {
      var res = await _dio.put(
        ApiRouter.settingProfile,
        data: {
          'lastName': lastName,
          'firstName': firstName,
        },
      );
      var raw = RawSuccessModel.fromMap(res.data);
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: raw.success ?? false,
      );
    } on DioError catch (ex) {
      if (ex.error is AppMessage) {
        return ResponseModel<bool>(
          type: ResponseModelType.failure,
          message: ex.error,
        );
      } else {
        var raw = RawFailureModel.fromMap(
          ex.response?.data ??
              {
                'statusCode': 444,
                'message': 'Không có dữ liệu trả về!',
              },
        );
        return ResponseModel<bool>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.error,
            title: raw.error ?? txtErrorTitle,
            content: raw.message ?? 'Không có dữ liệu trả về!',
          ),
        );
      }
    } on Exception catch (ex) {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }

  @override
  Future<ResponseModel<List<AddressEntity>>> searchAddressesByText({
    required String address,
    Location? origin,
  }) async {
    try {
      final places = GoogleMapsPlaces(apiKey: ApiRouter.googlePlacesApiKey);
      final result = await places.autocomplete(
        address,
        language: 'vi',
        origin: origin,
        components: [Component('country', 'vn')],
      );
      // printresult.predictions.map((e) => e.toJson()));
      if (result.status == "OK") {
        return ResponseModel<List<AddressEntity>>(
          type: ResponseModelType.success,
          data: result.predictions
              .map((e) => AddressEntity(
                    id: e.placeId,
                    name: e.structuredFormatting?.mainText ?? txtUnknown,
                    address: e.description,
                    meters: e.distanceMeters ?? 0,
                  ))
              .toList(),
        );
      } else {
        throw Exception(result.errorMessage);
      }
    } on Exception catch (ex) {
      return ResponseModel<List<AddressEntity>>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }

  @override
  Future<ResponseModel<List<AddressEntity>>> searchAddressesByLocation({
    required Location location,
    required double radius,
  }) async {
    try {
      final places = GoogleMapsPlaces(apiKey: ApiRouter.googlePlacesApiKey);
      final result = await places.searchNearbyWithRadius(
        location,
        radius,
        language: 'vi',
      );
      for (var e in result.results) {
        // printe.toJson());
      }
      if (result.status == "OK") {
        return ResponseModel<List<AddressEntity>>(
          type: ResponseModelType.success,
          data: result.results
              .where(
                (e) =>
                    !e.types.contains("locality") && !e.types.contains("route"),
              )
              .map((e) => AddressEntity(
                    id: e.placeId,
                    icon: e.icon,
                    name: e.name,
                    address: e.formattedAddress,
                    lat: e.geometry?.location.lat ?? 10.45,
                    lng: e.geometry?.location.lng ?? 106.7,
                  ))
              .toList(),
        );
      } else {
        throw Exception(result.errorMessage);
      }
    } on Exception catch (ex) {
      return ResponseModel<List<AddressEntity>>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }

  @override
  Future<ResponseModel<AddressEntity>> searchPlaceById(
      {required String id}) async {
    try {
      final places = GoogleMapsPlaces(apiKey: ApiRouter.googlePlacesApiKey);
      final result = await places.getDetailsByPlaceId(id, language: 'vi');
      if (result.status == "OK") {
        var e = result.result;
        return ResponseModel<AddressEntity>(
          type: ResponseModelType.success,
          data: AddressEntity(
            id: e.placeId,
            icon: e.icon,
            name: e.name,
            address: e.formattedAddress,
            lat: e.geometry?.location.lat ?? 10.45,
            lng: e.geometry?.location.lng ?? 106.7,
          ),
        );
      } else {
        throw Exception(result.errorMessage);
      }
    } on Exception catch (ex) {
      return ResponseModel<AddressEntity>(
        type: ResponseModelType.failure,
        message: AppMessage(
          title: txtErrorTitle,
          type: AppMessageType.error,
          content: 'Chưa phân tích được lỗi',
          description: ex.toString(),
        ),
      );
    }
  }
}
