import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:member_app/data/models/response_model.dart';
import 'package:member_app/exception/app_message.dart';

import '../../data/services/secure_storage.dart';

part '../states/geolocator_state.dart';

class GeolocatorCubit extends Cubit<GeolocatorState> {
  final SecureStorage _storage = SecureStorage();
  GeolocatorCubit() : super(const GeolocatorState()) {
    _storage.getLatLng().then((res) {
      // printres);
      if (res.type == ResponseModelType.success) {
        emit(GeolocatorState(latLng: res.data));
      } else {
        uploadPosition();
      }
    });
  }

  Future<AppMessage?> uploadPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      return AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi',
        content: 'Định vị đã bị tắt!',
        description:
        'Location services are disabled.',
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi',
          content: 'Quyền truy cập vị trí bị từ chối!',
          description:
          'Location permissions are permanently denied, we cannot request permissions.',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi',
        content: 'Quyền truy cập vị trí bị từ chối vĩnh viễn, chúng tôi không thể yêu cầu quyền.',
        description:
            'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var pos = await Geolocator.getCurrentPosition();
    emit(state.copyWith(latLng: LatLng(pos.latitude, pos.longitude)));
    _storage.persistLatLng(LatLng(pos.latitude, pos.longitude));
    // printLatLng(pos.latitude, pos.longitude).toJson());
    return null;
  }

// base method: return response model, use to avoid repeat code.

// action method, change state and return AppMessage?, null when success

// get data method: return model if state is loaded, else return null
}
