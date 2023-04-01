class CategoryModel {
  final String id;
  final String name;
  final String image;
  final String slug;
  final List<String> productIDs;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
    required this.productIDs,
  });
}