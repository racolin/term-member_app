import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/screens/news_screen.dart';
import 'package:member_app/presentation/widgets/news/news_item_widget.dart';
import '../../../business_logic/cubits/news_cubit.dart';
import '../../../business_logic/states/news_state.dart';

import '../../../data/models/news_model.dart';
import '../../res/dimen/dimens.dart';
import '../../res/strings/values.dart';
import 'news_widget.dart';

class NewsSectionWidget extends StatefulWidget {
  const NewsSectionWidget({Key? key}) : super(key: key);

  @override
  State<NewsSectionWidget> createState() => _NewsSectionWidgetState();
}

class _NewsSectionWidgetState extends State<NewsSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case NewsInitial:
            return const SizedBox();
          case NewsLoading:
            return const SizedBox();
          case NewsLoaded:
            state as NewsLoaded;
            return Padding(
              padding: const EdgeInsets.all(spaceXS),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        txtNews,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: fontLG,
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(spaceXS),
                        onTap: () => _toNewsScreen(state.list),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                            vertical: spaceXXS,
                            horizontal: spaceXS,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                txtSeeMore,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontMD,
                                  color: Colors.orange,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: fontLG,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: spaceXS),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: spaceSM,
                      children: state
                          .getsAll()
                          .map((e) => NewsItemWidget(width: 140, newsItem: e))
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
        }
        return const SizedBox();
      },
    );
  }

  void _toNewsScreen(List<NewsModel> news) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return NewsScreen(news: news);
        },
      ),
    );
  }
}
