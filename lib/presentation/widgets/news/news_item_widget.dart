import 'dart:math';

import 'package:flutter/material.dart';
import 'package:member_app/presentation/widgets/app_image_widget.dart';

import '../../../supports/convert.dart';
import '../../../data/models/news_model.dart';
import '../../res/dimen/dimens.dart';
import '../../res/strings/values.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsItemWidget extends StatelessWidget {
  final NewsItemModel newsItem;
  final double width;
  final double imageHeight;

  const NewsItemWidget({
    Key? key,
    required this.newsItem,
    this.width = double.maxFinite,
    this.imageHeight = 130,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toNews(context),
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(spaceXS),
              child: AppImageWidget(
                width: width,
                height: imageHeight,
                image: newsItem.image,
                borderRadius: BorderRadius.circular(spaceXXS),
              ),
            ),
            const SizedBox(height: spaceXXS),
            Text(
              newsItem.name.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: fontMD,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: spaceXXS),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.access_time,
                  size: fontMD,
                ),
                const SizedBox(width: spaceXXS),
                Text(
                  dateToString(newsItem.time, 'dd/MM'),
                  style: const TextStyle(fontSize: fontSM),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toNews(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              splashRadius: spaceLG,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                size: fontXL,
              ),
            ),
            actions: [
              IconButton(
                splashRadius: spaceLG,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: const Icon(
                    Icons.reply_outlined,
                    size: fontXL,
                  ),
                ),
              ),
              const SizedBox(
                width: spaceXXS,
              ),
            ],
            title: const Text(
              txtNews,
              style: TextStyle(
                fontSize: fontLG,
              ),
            ),
          ),
          body: WebViewWidget(
            controller: WebViewController()
              ..loadRequest(
                Uri.parse(newsItem.url),
              ),
          ),
        ),
      ),
    );
  }
}
