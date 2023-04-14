import 'package:member_app/presentation/res/strings/values.dart';

class CartModel {
  final String id;
  final String name;
  final int categoryId;
  final int cost;
  final DateTime time;
  final int? rate;

  const CartModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.cost,
    required this.time,
    this.rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'cost': cost,
      'time': time.millisecondsSinceEpoch,
      'rate': rate,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
      categoryId: map['categoryId']!,
      cost: map['cost'] ?? 0,
      time: map['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['time'])
          : DateTime.now(),
      rate: map['rate'],
    );
  }
}