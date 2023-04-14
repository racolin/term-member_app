import 'package:member_app/presentation/res/strings/values.dart';

class ProfileModel {
  final String firstName;
  final String lastName;
  final DateTime dob;
  final int gender;
  final String phone;

  const ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob,
      'gender': gender,
      'phone': phone,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      firstName: map['firstName'] ?? txtNone,
      lastName: map['lastName'] ?? txtNone,
      dob: map['dob'] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(map['dob']),
      gender: map['gender'] ?? 0,
      phone: map['phone'] ?? txtNone,
    );
  }
}
