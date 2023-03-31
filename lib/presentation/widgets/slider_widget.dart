import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/pages/loading_page.dart';

import '../../business_logic/cubits/slider_cubit.dart';
import '../../business_logic/cubits/slider_state.dart';
import '../res/dimen/dimens.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

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
            return const LoadingWidget();
          case SliderLoaded:
            state as SliderLoaded;
            return Container(
              margin: const EdgeInsets.all(spaceXS),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(spaceSM),
                    child: CarouselSlider(
                      items: state.sliders
                          .map((e) => ClipRRect(
                        borderRadius: BorderRadius.circular(spaceSM),
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.network(
                            e.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))
                          .toList(),
                      options: CarouselOptions(
                        onScrolled: (value) {
                          if (value != null) {
                            var v = (value - 10000).floor() % state.sliders.length;
                            var space =
                                (120 - state.sliders.length * 24) / (state.sliders.length - 1) +
                                    24;
                            setState(() {
                              if (v == state.sliders.length - 1) {
                                _left = (state.sliders.length - 1) *
                                    space *
                                    (1 - value + value.floor());
                              } else {
                                _left = v * space + (value - value.floor()) * space;
                              }
                            });
                          }
                        },
                        autoPlay: true,
                        autoPlayAnimationDuration:
                        const Duration(milliseconds: 300),
                        autoPlayCurve: Curves.easeInOut,
                        autoPlayInterval: const Duration(seconds: 5),
                        aspectRatio: 2,
                        viewportFraction: 1,
                        initialPage: 0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: _left),
                        width: 24,
                        height: 2,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            state.sliders.length,
                                (index) => Container(
                              width: 24,
                              height: 2,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(2),
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
}
