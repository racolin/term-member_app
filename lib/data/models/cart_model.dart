import 'package:member_app/presentation/res/strings/values.dart';

enum DeliveryType {
  inStore(txtInStore, txtInStoreDetail, 'assets/images/image_in_store.png'),
  takeOut(txtTake, txtTakeDetail, 'assets/images/image_take_away.png'),
  delivery(txtDelivery, txtDeliveryDetail, 'assets/images/image_delivery.jpeg');

  final String name;
  final String description;
  final String image;

  const DeliveryType(this.name, this.description, this.image);
}

class CartModel {
  final String id;
  final String name;
  final DeliveryType categoryId;
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
      'categoryId': categoryId.index,
      'cost': cost,
      'time': time.millisecondsSinceEpoch,
      'rate': rate,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id']!,
      name: map['name'] ?? txtUnknown,
      categoryId: DeliveryType.values[map['categoryId']!],
      cost: map['cost'] ?? 0,
      time: map['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['time'])
          : DateTime.now(),
      rate: map['rate'],
    );
  }

  CartModel copyWith({
    String? id,
    String? name,
    DeliveryType? categoryId,
    int? cost,
    DateTime? time,
    int? rate,
  }) {
    return CartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      cost: cost ?? this.cost,
      time: time ?? this.time,
      rate: rate ?? this.rate,
    );
  }
}