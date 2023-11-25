part of '../cubits/geolocator_cubit.dart';


class GeolocatorState {
  final LatLng? _latLng;


  GeolocatorState copyWith({
    LatLng? latLng,
  }) {
    return GeolocatorState(
      latLng: latLng ?? _latLng,
    );
  }

  LatLng get latLng => _latLng ?? const LatLng(10.762622, 106.660172);

  const GeolocatorState({
    LatLng? latLng,
  }) : _latLng = latLng;
}

