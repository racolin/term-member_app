import 'package:flutter/foundation.dart';
import 'package:member_app/exception/app_message.dart';

import '../../data/models/profile_model.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  ProfileLoaded({
    required this.profile,
  });

  ProfileLoaded copyWith({
    ProfileModel? profile,
  }) {
    return ProfileLoaded(
      profile: profile ?? this.profile,
    );
  }
}

class ProfileFailure extends ProfileState {
  final AppMessage message;
  ProfileFailure({required this.message});
}
