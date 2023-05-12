import 'package:barcode/barcode.dart';

extension StringExtension on String {
  String barcode([
    double? width,
    double? height,
    double? fontHeight,
  ]) {
    return Barcode.code128(
      useCode128A: false,
      useCode128C: false,
    ).toSvg(this,
        width: width ?? 300,
        height: height ?? 76,
        fontHeight: fontHeight,
        textPadding: 16);
  }

  String qrCode([
    double? width,
    double? height,
    double? fontHeight,
  ]) {
    return Barcode.qrCode().toSvg(this,
        width: width ?? 300,
        height: height ?? 76,
        fontHeight: fontHeight,
        textPadding: 16);
  }
}
