class PromotionModel {
  final String id;
  final String image;
  final String partner;
  final String title;
  final String description;
  final DateTime expire;
  final int userFor;
  final int score;

  PromotionModel({
    required this.id,
    required this.image,
    required this.partner,
    required this.title,
    required this.description,
    required this.expire,
    required this.userFor,
    required this.score,
  });
}
