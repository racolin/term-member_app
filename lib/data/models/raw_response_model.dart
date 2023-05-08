class RawResponseModel {
  final int statusCode;
  final String? error;
  final String? message;
  final bool? success;
  final dynamic data;

  const RawResponseModel({
    required this.statusCode,
    required this.error,
    required this.message,
    required this.success,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'error': error,
      'message': message,
      'success': success,
      'data': data,
    };
  }

  factory RawResponseModel.fromMap(Map<String, dynamic> map) {
    return RawResponseModel(
      statusCode: map['statusCode']!,
      error: map['error'],
      message: map['message'],
      success: map['success'] ?? false,
      data: map['data'],
    );
  }
}