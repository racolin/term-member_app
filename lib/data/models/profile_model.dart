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
    String phone = map['phone'] ?? txtNone;
    phone = phone.replaceRange(0, 3, '');
    return ProfileModel(
      firstName: map['firstName'] ?? txtNone,
      lastName: map['lastName'] ?? txtNone,
      dob: DateTime.tryParse(map['dob'] ?? '') ?? DateTime.now(),
      // map['dob'] == null
      //     ? DateTime.now()
      //     : DateTime.fromMillisecondsSinceEpoch(map['dob']),
      gender: map['gender'] ?? 0,
      phone: phone,
    );
  }

  ProfileModel copyWith({
    String? firstName,
    String? lastName,
    DateTime? dob,
    int? gender,
    String? phone,
  }) {
    return ProfileModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
    );
  }
}
