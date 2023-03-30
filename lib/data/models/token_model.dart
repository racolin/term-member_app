class TokenModel {
  TokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiredTime,
  });

  final String accessToken;
  final String refreshToken;
  final int expiredTime;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    expiredTime: int.tryParse(json['expired_time'].toString()) ?? 0,
    accessToken: json['access_token'] as String,
    refreshToken: json['refresh_token'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'expired_time': expiredTime,
  };

  @override
  String toString() {
    return 'Token{access_token: $accessToken, refresh_token: $refreshToken, expired_time: $expiredTime, }';
  }
}