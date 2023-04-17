import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/strings/values.dart';

class AppImageWidget extends StatelessWidget {
  final String? image;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final String? cachedKey;
  final String assetsDefaultImage;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  const AppImageWidget({
    Key? key,
    required this.image,
    this.imageBuilder,
    this.errorWidget,
    this.cachedKey,
    this.assetsDefaultImage = assetDefaultImage,
    this.height = double.maxFinite,
    this.width = double.maxFinite,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        cacheKey: cachedKey,
        imageUrl: image ?? '',
        imageBuilder: imageBuilder,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorWidget: errorWidget ?? (context, url, error) => Image.asset(
          assetsDefaultImage,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
        placeholder: (context, url) => Image.asset(
          assetsDefaultImage,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
