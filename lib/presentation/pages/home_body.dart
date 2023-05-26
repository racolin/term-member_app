import 'package:flutter/material.dart';

import '../widgets/card_home_widget.dart';
import '../res/strings/values.dart';
import '../widgets/app_image_widget.dart';
import '../res/dimen/dimens.dart';
import '../widgets/news/news_section_widget.dart';
import '../widgets/product/products_suggest_widget.dart';
import '../widgets/card_widget.dart';
import '../widgets/delivery/delivery_options_widget.dart';
import '../widgets/drag_bar_widget.dart';
import '../widgets/re_orders_widget.dart';
import '../widgets/slide/slider_widget.dart';

class HomeBody extends StatefulWidget {
  final VoidCallback onScroll;
  final bool login;

  const HomeBody({
    Key? key,
    required this.onScroll,
    required this.login,
  }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  double collapseHeight = 336;
  double oldPixel = 0;
  double gap = 2;
  double direction = -1;

  @override
  void initState() {
    super.initState();
  }

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
              background: AppImageWidget(
                height: collapseHeight,
                image:
                    "https://png.pngtree.com/background/20210709/original/pngtree-simple-style-coffee-bean-food-and-drinks-poster-background-picture-image_905716.jpg",
                errorWidget: (ctx, url, error) {
                  return Container(
                    height: collapseHeight,
                    padding: const EdgeInsets.only(
                      top: spaceLG,
                      left: spaceXS,
                      right: spaceXS,
                      bottom: 76,
                    ),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(assetDefaultImage),
                      ),
                    ),
                    child: const CardWidget(
                      isDetail: false,
                    ),
                  );
                },
                imageBuilder: (ctx, provider) {
                  return Container(
                    height: collapseHeight,
                    padding: const EdgeInsets.only(
                      top: spaceLG,
                      left: spaceXS,
                      right: spaceXS,
                      bottom: 76,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: provider,
                      ),
                    ),
                    child: widget.login
                        ? const CardWidget(
                            isDetail: false,
                          )
                        : const CardHomeWidget(),
                  );
                },
              ),
            ),
          ),
        ];
      },
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (!notification.metrics.outOfRange) {
            if ((notification.metrics.pixels - oldPixel).abs() > gap &&
                notification.metrics.axis == Axis.vertical) {
              double sub = notification.metrics.pixels - oldPixel;
              if (direction * sub > 0) {
                direction = -direction;
                widget.onScroll();
              }
            }
            oldPixel = notification.metrics.pixels;
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DragBarWidget(margin: spaceXS),
              const DeliveryOptionsWidget(),
              if (widget.login) const SliderWidget(),
              if (widget.login) const ProductsSuggestWidget(height: 307),
              if (widget.login) const ReOrdersWidget(),
              const NewsSectionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
