class TransactionStatusModel {
  final String partnerCode;
  final String requestId;
  final String orderId;
  final String extraData;
  final int amount;
  final int transId;
  final String payType;
  final int resultCode;
  // List<dynamic> refundTrans;
  final String message;
  final int responseTime;
  final String signature;
  final String paymentOption;

  const TransactionStatusModel({
    required this.partnerCode,
    required this.requestId,
    required this.orderId,
    required this.extraData,
    required this.amount,
    required this.transId,
    required this.payType,
    required this.resultCode,
    required this.message,
    required this.responseTime,
    required this.signature,
    required this.paymentOption,
  });

  Map<String, dynamic> toMap() {
    return {
      'partnerCode': partnerCode,
      'requestId': requestId,
      'orderId': orderId,
      'extraData': extraData,
      'amount': amount,
      'transId': transId,
      'payType': payType,
      'resultCode': resultCode,
      'message': message,
      'responseTime': responseTime,
      'signature': signature,
      'paymentOption': paymentOption,
    };
  }

  factory TransactionStatusModel.fromMap(Map<String, dynamic> map) {
    return TransactionStatusModel(
      partnerCode: map['partnerCode'] as String,
      requestId: map['requestId'] as String,
      orderId: map['orderId'] as String,
      extraData: map['extraData'] as String,
      amount: map['amount'] as int,
      transId: map['transId'] as int,
      payType: map['payType'] as String,
      resultCode: map['resultCode'] as int,
      message: map['message'] as String,
      responseTime: map['responseTime'] as int,
      signature: map['signature'] as String,
      paymentOption: map['paymentOption'] as String,
    );
  }
}