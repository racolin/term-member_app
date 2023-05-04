class TokenModel {
  TokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };

  @override
  String toString() {
    return 'Token{accessToken: $accessToken, refreshToken: $refreshToken }';
  }
}