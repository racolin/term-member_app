class RawSuccessModel {
  final bool? success;
  final dynamic data;

  const RawSuccessModel({
    required this.success,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'data': data,
    };
  }

  factory RawSuccessModel.fromMap(Map<String, dynamic> map) {
    return RawSuccessModel(
      success: map['success'] ?? false,
      data: map['data'],
    );
  }
}