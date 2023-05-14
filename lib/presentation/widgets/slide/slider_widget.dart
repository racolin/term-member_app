import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/bottom_sheet/voucher_bottom_sheet.dart';
import 'package:member_app/presentation/pages/loading_page.dart';
import '../../../business_logic/cubits/voucher_cubit.dart';
import '../../../business_logic/states/voucher_state.dart';
import '../../res/dimen/dimens.dart';
import '../app_image_widget.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoucherCubit, VoucherState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case VoucherLoading:
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(spaceXL),
                child: LoadingWidget(),
              ),
            );
          case VoucherLoaded:
            state as VoucherLoaded;
            var list = state.listSlider;
            final double widthTotal = spaceLG * (list.length + spaceXXS / 4);
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
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return VoucherBottomSheet(voucher: e);
                                    },
                                  ).then((type) {
                                    // if (type != null &&
                                    //     type is HomeBodyType) {
                                    //   context.read<HomeCubit>().setBody(type);
                                    // }
                                  });
                                },
                                child: AppImageWidget(
                                  image: e.sliderImage,
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
                            var space = (widthTotal - list.length * spaceLG) /
                                    (list.length - 1) +
                                spaceLG;
                            setState(() {
                              if (v == list.length - 1) {
                                _left = (list.length - 1) *
                                    space *
                                    (1 - value + value.floor());
                              } else {
                                _left =
                                    v * space + (value - value.floor()) * space;
                              }
                            });
                          }
                        },
                        autoPlay: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 300),
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
                        width: spaceLG,
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
                              width: spaceLG,
                              height: 2,
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
}
