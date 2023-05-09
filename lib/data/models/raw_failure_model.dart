class RawFailureModel {
  final String? error;
  final String? message;

  const RawFailureModel({
    required this.error,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'message': message,
    };
  }

  factory RawFailureModel.fromMap(Map<String, dynamic> map) {
    return RawFailureModel(
      error: map['error'],
      message: (map['message'] is List)
          ? (map['message'] as List).join('\n')
          : map['message'],
    );
  }
}
