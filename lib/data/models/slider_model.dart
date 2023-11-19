class SliderModel {
  final String id;
  final String image;
  final String? url;

  SliderModel({
    required this.id,
    required this.image,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'url': url,
    };
  }

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id'] as String,
      image: map['image'] as String,
      url: map['url'] as String?,
    );
  }
}
