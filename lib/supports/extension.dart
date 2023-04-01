import 'package:barcode/barcode.dart';

extension StringExtension on String {
  String barcode(
      [double? width,
        double? height,
        double? fontHeight,]
      ) {
    return Barcode.code128(useCode128B: false, useCode128C: false).toSvg(
      this,
      width: width ?? 300,
      height: height ?? 60,
      fontHeight: fontHeight,
    );
  }
}