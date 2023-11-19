import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../business_logic/cubits/slider_cubit.dart';
import '../../../business_logic/states/slider_state.dart';
import '../../pages/loading_page.dart';
import '../../res/dimen/dimens.dart';
import '../../res/strings/values.dart';
import '../app_image_widget.dart';

class SliderWidget extends StatefulWidget {
  final double height;
  final double bottomWidth;
  final double spacing;
  final Duration duration;

  const SliderWidget({
    Key? key,
    this.height = 180,
    this.bottomWidth = 16,
    this.spacing = 2,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case SliderLoading:
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(spaceXL),
                child: LoadingWidget(),
              ),
            );
          case SliderLoaded:
            state as SliderLoaded;
            var list = state.list;
            var length = list.length;
            if (length == 0) {
              return const SizedBox();
            }
            if (length == 1) {
              return Container(
                padding: const EdgeInsets.all(spaceXS),
                height: widget.height,
                width: double.maxFinite,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(spaceXS),
                  child: GestureDetector(
                    onTap: state.list[0].url == null ? null : () => _toWebViewSlider(state.list[0].url!),
                    child: AppImageWidget(
                      image: state.list[0].image,
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              );
            }

            final double widthTotal = list.length * (widget.bottomWidth + widget.spacing);
            return Container(
              margin: const EdgeInsets.all(spaceXS),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(spaceSM),
                    child: CarouselSlider(
                      items: list
                          .map(
                            (e) => ClipRRect(
                          borderRadius: BorderRadius.circular(spaceSM),
                          child: GestureDetector(
                            onTap: e.url == null ? null : () => _toWebViewSlider(e.url!),
                            child: AppImageWidget(
                              image: e.image,
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                      options: CarouselOptions(
                        onScrolled: (value) {
                          if (value != null) {
                            var v = (value - 10000).floor() % list.length;
                            var space = (widthTotal - list.length * widget.bottomWidth) /
                                (list.length - 1) +
                                widget.bottomWidth;
                            setState(() {
                              if (v == list.length - 1) {
                                _left = (list.length - 1) *
                                    space *
                                    (1 - value + value.floor());
                              } else {
                                ///
                                _left =
                                    v * space + (value - value.floor()) * space;
                              }
                            });
                          }
                        },
                        autoPlay: true,
                        autoPlayAnimationDuration: widget.duration,
                        autoPlayCurve: Curves.easeInOut,
                        autoPlayInterval: const Duration(seconds: 7),
                        aspectRatio: 2,
                        viewportFraction: 1,
                        initialPage: 0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: spaceXS,
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: _left),
                        width: widget.bottomWidth,
                        height: spaceXXS / 2,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(spaceXXS / 2),
                        ),
                      ),
                      SizedBox(
                        width: widthTotal,
                        height: spaceXXS,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            list.length,
                                (index) => Container(
                              width: widget.bottomWidth,
                              height: spaceXXS / 2,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius:
                                BorderRadius.circular(spaceXXS / 2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }

  void _toWebViewSlider(String url) {
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
              txtSlider,
              style: TextStyle(
                fontSize: fontLG,
              ),
            ),
          ),
          body: WebViewWidget(
            controller: WebViewController()
              ..loadRequest(
                Uri.parse(url),
              ),
          ),
        ),
      ),
    );
  }

}
