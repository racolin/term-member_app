import 'dart:math';

import 'package:barcode/barcode.dart';
import 'package:intl/intl.dart';

String numberToCurrency(num x, String symbol) {
  return '${NumberFormat.currency(locale: 'en_US', symbol: '', decimalDigits: 0).format(x)}$symbol';
}

String numberToAcronym(num number) {
  return NumberFormat.compact(locale: 'en_US').format(number);
}

String doubleToPercent(double x) {
  return '${(x * 100).toStringAsFixed(2)}%';
}

String dateToString(DateTime dateTime, String format) {
  return DateFormat(format).format(dateTime);
}

String secondToTime(int count) {
  var minutes = count ~/ 60;
  var seconds = count % 60;
  return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}

String meterToString(int meter) {
  if (meter < 300) {
    return '${meter} m';
  } else {
    return '${(meter / 1000).toStringAsPrecision(2)} km';
  }
}

String toBarcodeString(
  String barcode, [
  double? width,
  double? height,
  double? fontHeight,
]) {
  return Barcode.code128(useCode128B: false, useCode128C: false).toSvg(
    barcode,
    width: width ?? 300,
    height: height ?? 60,
    fontHeight: fontHeight,
  );
}

int toInt(String str) {
  return int.tryParse(str) ?? 0;
}

String positionToDistanceString(
  double curLat,
  double curLng,
  double lat,
  double lng,
) {
  curLat = _toRadians(curLat);
  curLng = _toRadians(curLng);
  lat = _toRadians(lat);
  lng = _toRadians(lng);

  double ln = lng - curLng;
  double lt = lat - curLat;

  double ans =
      pow(sin(lt / 2), 2) + cos(curLat) * cos(lat) * pow(sin(ln / 2), 2);

  ans = 2 * asin(sqrt(ans));

  double R = 6371;

  ans = ans * R;

  if (ans >= 1) {
    return '${ans.toInt()} km';
  }
  return '${(ans * 1000).toInt()} m';
}

int positionToDistance(
  double curLat,
  double curLng,
  double lat,
  double lng,
) {
  curLat = _toRadians(curLat);
  curLng = _toRadians(curLng);
  lat = _toRadians(lat);
  lng = _toRadians(lng);

  double ln = lng - curLng;
  double lt = lat - curLat;

  double ans =
      pow(sin(lt / 2), 2) + cos(curLat) * cos(lat) * pow(sin(ln / 2), 2);

  ans = 2 * asin(sqrt(ans));

  double R = 6371;

  ans = ans * R;
  return (ans * 1000).toInt();
}

double _toRadians(double degree) {
  double oneDeg = pi / 180;
  return (oneDeg * degree);
}

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
