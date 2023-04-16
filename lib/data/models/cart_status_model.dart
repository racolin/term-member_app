import '../../presentation/res/strings/values.dart';

class CartStatusModel {
  final String id;
  final String name;

  const CartStatusModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CartStatusModel.fromMap(Map<String, dynamic> map) {
    return CartStatusModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
    );
  }
}