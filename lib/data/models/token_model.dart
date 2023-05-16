class TokenModel {
  TokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory TokenModel.fromMap(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };

  @override
  String toString() {
    return 'Token{accessToken: $accessToken, refreshToken: $refreshToken }';
  }
}