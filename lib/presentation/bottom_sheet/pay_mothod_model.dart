enum PayMethodType { cash, momo, zalo, shopee, bank }

class PayMethod {
  final String name;
  final String image;
  final PayMethodType type;

  PayMethod({
    required this.name,
    required this.image,
    required this.type,
  });
}