import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/widgets/slider_widget.dart';

import '../widgets/app_bar_widget.dart';
import '../widgets/drag_bar_widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  double collapseHeight = 360;

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
                // child: const CardWidget(isDetail: false),
              ),
            ),
          ),
        ];
      },
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DragBarWidget(margin: spaceXS),
            _getOptions(height: dimXL, margin: spaceXS),
            const SliderWidget(),
            const SizedBox(
              height: 1000,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getOptions({
    required double height,
    required double margin,
  }) {
    return Container(
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.6),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: getOption(
              'Giao hàng',
              'https://static.vecteezy.com/system/resources/previews/008/492/234/original/delivery-cartoon-illustration-png.png',
              height,
            ),
          ),
          Container(
            height: height * 0.6,
            width: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(150),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          Expanded(
            child: getOption(
              'Mang đi',
              'https://www.drench-design.com/wp-content/uploads/2018/10/coffeetype2.png',
              height,
            ),
          ),
        ],
      ),
    );
  }

  Widget getOption(String name, String image, double height) {
    return Container(
      alignment: Alignment.center,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            image,
            width: height * 0.5,
            height: height * 0.5,
            fit: BoxFit.cover,
          ),
          Text(name),
        ],
      ),
    );
  }
}
