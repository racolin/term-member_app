import 'package:flutter/material.dart';
import 'package:member_app/data/models/news_model.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/widgets/news/news_item_widget.dart';

class NewsWidget extends StatelessWidget {
  final List<NewsItemModel> newsList;

  const NewsWidget({
    Key? key,
    required this.newsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(spaceXS),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4 / 5,
        mainAxisSpacing: spaceSM,
        crossAxisSpacing: spaceSM,
      ),
      itemBuilder: (context, index) {
        return NewsItemWidget(
          newsItem: newsList[index],
          onClick: () {},
        );
      },
      itemCount: newsList.length,
    );
  }
}
