class RawResponseModel {
  final bool? success;
  final dynamic data;

  const RawResponseModel({
    required this.success,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'data': data,
    };
  }

  factory RawResponseModel.fromMap(Map<String, dynamic> map) {
    return RawResponseModel(
      success: map['success'] ?? false,
      data: map['data'],
    );
  }
}