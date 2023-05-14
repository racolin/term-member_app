import 'address_model.dart';

class AddressesListModel {
  final List<AddressModel> defaults;
  final List<AddressModel> others;

  const AddressesListModel({
    required this.defaults,
    required this.others,
  });

  Map<String, dynamic> toMap() {
    return {
      'defaultAddress': defaults,
      'otherAddress': others,
    };
  }

  factory AddressesListModel.fromMap(Map<String, dynamic> map) {
    return AddressesListModel(
      defaults: map['defaultAddress'] == null
          ? []
          : (map['defaultAddress'] as List)
              .map((e) => AddressModel.fromMap(e))
              .toList(),
      others: map['otherAddress'] == null
          ? []
          : (map['otherAddress'] as List)
          .map((e) => AddressModel.fromMap(e))
          .toList(),
    );
  }
}
