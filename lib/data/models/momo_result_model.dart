class MomoResultModel {
  final String partnerCode;
  final String requestId;
  final String orderId;
  final int amount;
  final int responseTime;
  final String message;
  final int resultCode;
  final String payUrl;
  final String? deeplink;
  final String? qrCodeUrl;
  final String? deeplinkMiniApp;
  final String? signature;

  const MomoResultModel({
    required this.partnerCode,
    required this.requestId,
    required this.orderId,
    required this.amount,
    required this.responseTime,
    required this.message,
    required this.resultCode,
    required this.payUrl,
    required this.deeplink,
    required this.qrCodeUrl,
    required this.deeplinkMiniApp,
    required this.signature,
  });

  Map<String, dynamic> toMap() {
    return {
      'partnerCode': partnerCode,
      'requestId': requestId,
      'orderId': orderId,
      'amount': amount,
      'responseTime': responseTime,
      'message': message,
      'resultCode': resultCode,
      'payUrl': payUrl,
      'deeplink': deeplink,
      'qrCodeUrl': qrCodeUrl,
      'deeplinkMiniApp': deeplinkMiniApp,
      'signature': signature,
    };
  }

  factory MomoResultModel.fromMap(Map<String, dynamic> map) {
    return MomoResultModel(
      partnerCode: map['partnerCode'] as String,
      requestId: map['requestId'] as String,
      orderId: map['orderId'] as String,
      amount: map['amount'] as int,
      responseTime: map['responseTime'] as int,
      message: map['message'] as String,
      resultCode: map['resultCode'] as int,
      payUrl: map['payUrl'] as String,
      deeplink: map['deeplink'],
      qrCodeUrl: map['qrCodeUrl'],
      deeplinkMiniApp: map['deeplinkMiniApp'],
      signature: map['signature'],
    );
  }
}
