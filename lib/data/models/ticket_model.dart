class TicketModel {
  final String id;
  final String image;
  final String title;
  final DateTime from;
  final DateTime expire;
  final String description;

  TicketModel({
    required this.id,
    required this.image,
    required this.title,
    required this.from,
    required this.expire,
    required this.description,
  });
}
