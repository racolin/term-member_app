import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/widgets/app_image_widget.dart';

import '../../supports/convert.dart';
import '../../business_logic/cubits/news_cubit.dart';
import '../../business_logic/states/news_state.dart';
import '../../data/models/news_model.dart';
import '../../presentation/res/dimen/dimens.dart';
import '../../presentation/res/strings/values.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsItemWidget extends StatelessWidget {
  final VoidCallback onClick;
  final NewsItemModel newsItem;

  const NewsItemWidget({
    Key? key,
    required this.newsItem,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var state = context.read<NewsCubit>().state;
        var title = txtDefault;
        if (state is NewsLoaded) {
          title = state.list[state.index].name;
        }
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
                title: Text(
                  title,
                  style: const TextStyle(
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
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(spaceXS),
            child: AppImageWidget(
              width: 400,
              height: 150,
              image: newsItem.image,
              borderRadius: BorderRadius.circular(spaceXXS),
            ),
          ),
          const SizedBox(height: spaceXS),
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
              const SizedBox(width: spaceXS),
              Text(
                dateToString(newsItem.time, 'dd/MM'),
                style: const TextStyle(fontSize: fontSM),
              )
            ],
          ),
        ],
      ),
    );
  }
}
