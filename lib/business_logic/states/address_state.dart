import 'package:flutter/foundation.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:member_app/exception/app_message.dart';

import '../../data/models/address_model.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<AddressModel> defaultAddresses;
  final List<AddressModel> otherAddresses;
  final Location? location;

  AddressLoaded({
    required this.defaultAddresses,
    required this.otherAddresses,
    this.location,
  });

  AddressLoaded copyWith({
    List<AddressModel>? defaultAddresses,
    List<AddressModel>? otherAddresses,
    Location? location,
  }) {
    return AddressLoaded(
      defaultAddresses: defaultAddresses ?? this.defaultAddresses,
      otherAddresses: otherAddresses ?? this.otherAddresses,
      location: location ?? this.location,
    );
  }
}

class AddressFailure extends AddressState {
  final AppMessage message;

  AddressFailure({
    required this.message,
  });
}
