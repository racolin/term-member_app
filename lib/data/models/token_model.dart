class TokenModel {
  TokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    accessToken: json['access_token'] as String,
    refreshToken: json['refresh_token'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'access_token': accessToken,
    'refresh_token': refreshToken,
  };

  @override
  String toString() {
    return 'Token{access_token: $accessToken, refresh_token: $refreshToken }';
  }
}