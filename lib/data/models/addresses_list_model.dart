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
      'defaults': defaults,
      'others': others,
    };
  }

  factory AddressesListModel.fromMap(Map<String, dynamic> map) {
    return AddressesListModel(
      defaults: map['defaults'] == null
          ? []
          : (map['defaults'] as List)
              .map((e) => AddressModel.fromMap(e))
              .toList(),
      others: map['others'] == null
          ? []
          : (map['others'] as List)
          .map((e) => AddressModel.fromMap(e))
          .toList(),
    );
  }
}
