import 'package:flutter/material.dart';

import '../app_image_widget.dart';

class SlideImagesWidget extends StatelessWidget {
  final double separator;
  final double height;
  final double itemWidth;
  final List<String> images;
  final BorderRadius? borderRadius;

  const SlideImagesWidget({
    Key? key,
    required this.height,
    required this.separator,
    required this.itemWidth,
    required this.images,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius,
        // height: 300,
        child: images.length < 2
            ? AppImageWidget(
                image: images.isEmpty ? null : images[0],
                height: height,
                width: double.maxFinite,
                borderRadius: borderRadius,
              )
            : ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  width: separator,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  BorderRadius corner = BorderRadius.zero;
                  if (index == 0) {
                    corner = BorderRadius.only(
                      topLeft: borderRadius?.topLeft ?? Radius.zero,
                    );
                  } else if (index == images.length - 1) {
                    corner = BorderRadius.only(
                      topRight: borderRadius?.topRight ?? Radius.zero,
                    );
                  }
                  return AppImageWidget(
                    image: images[index],
                    height: height,
                    width: itemWidth,
                    borderRadius: corner,
                  );
                },
              ),
      ),
    );
  }
}
