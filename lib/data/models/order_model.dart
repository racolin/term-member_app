enum OrderType { delivery, takeOut, inStore }

class OrderModel {
  final String title;
  final String icon;
  final OrderType type;
  final String address;
  final DateTime dateTime;
  final double price;

  OrderModel({
    required this.title,
    required this.icon,
    required this.type,
    required this.address,
    required this.dateTime,
    required this.price,
  });
}

class OrdersModel {
  final String title;
  final List<OrderModel> orders;

  OrdersModel({
    required this.title,
    required this.orders,
  });
}
