class RawResponseModel {
  final String? error;
  final String? message;

  const RawResponseModel({
    required this.error,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'message': message,
    };
  }

  factory RawResponseModel.fromMap(Map<String, dynamic> map) {
    return RawResponseModel(
      error: map['error'],
      message: map['message'],
    );
  }
}