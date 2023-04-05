import 'package:flutter/material.dart';
import 'package:member_app/presentation/widgets/re_order_widget.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/widgets/news_section_widget.dart';
import 'package:member_app/presentation/widgets/slider_widget.dart';
import 'package:member_app/presentation/widgets/suggest_products_widget.dart';

import '../widgets/card_widget.dart';
import '../widgets/delivery_options_widget.dart';
import '../widgets/drag_bar_widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  double collapseHeight = 336;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: collapseHeight,
            collapsedHeight: 0,
            toolbarHeight: 0,
            floating: true,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              centerTitle: true,
              background: Container(
                height: collapseHeight,
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 8,
                  right: 8,
                  bottom: 76,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://images.pexels.com/photos/4148020/pexels-photo-4148020.jpeg",
                    ),
                  ),
                ),
                child: const CardWidget(isDetail: false),
              ),
            ),
          ),
        ];
      },
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            DragBarWidget(margin: spaceXS),
            DeliveryOptionsWidget(),
            SliderWidget(),
            ReOrdersWidget(),
            SuggestProductsWidget(),
            NewsSectionWidget(),
            SizedBox(
              height: dimMD,
            ),
          ],
        ),
      ),
    );
  }
}
