import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/voucher_cubit.dart';

import '../widgets/card_home_widget.dart';
import '../res/strings/values.dart';
import '../widgets/app_image_widget.dart';
import '../res/dimen/dimens.dart';
import '../widgets/news/news_section_widget.dart';
import '../widgets/product/product_section_widget.dart';
import '../widgets/product/products_suggest_widget.dart';
import '../widgets/card_widget.dart';
import '../widgets/delivery/delivery_options_widget.dart';
import '../widgets/drag_bar_widget.dart';
import '../widgets/re_orders_widget.dart';
import '../widgets/re_templates_widget.dart';
import '../widgets/slider/slider_widget.dart';

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
    return NotificationListener<ScrollNotification>(
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
      child: RefreshIndicator(
        onRefresh: () async {
          if (widget.login) {
            
          }
        },
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.login
                  ? const CardWidget(isDetail: false)
                  : const CardHomeWidget(),
              DeliveryOptionsWidget(login: widget.login),
              const SliderWidget(),
              if (widget.login) const ProductsSuggestWidget(height: 307),
              if (widget.login) const ReOrdersWidget(),
              if (widget.login) const ReTemplatesWidget(),
              const NewsSectionWidget(),
              ProductSectionWidget(login: widget.login),
              const SizedBox(height: dimMD),
            ],
          ),
        ),
      ),
    );
  }
}
