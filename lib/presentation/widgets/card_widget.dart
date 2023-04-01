import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:member_app/business_logic/cubits/card_cubit.dart';
import 'package:member_app/data/models/card_model.dart';
import 'package:member_app/supports/extension.dart';

import '../../business_logic/cubits/card_state.dart';

class CardWidget extends StatelessWidget {
  final bool isDetail;

  const CardWidget({
    Key? key,
    this.isDetail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCubit, CardState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case CardInitial:
            return Container();
          case CardLoading:
            return Container();
          case CardLoaded:
            state as CardLoaded;
            return Stack(
              children: [
                if (isDetail) _getDetail(state.card),
                SizedBox(
                  height: 200,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.orange,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(
                              state.card.background,
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _getInfo(state.card),
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.only(right: 16),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.brown,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.keyboard_double_arrow_down_outlined,
                                      color: Colors.white.withAlpha(200),
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      'Tích điểm',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 96,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            margin: const EdgeInsets.only(
                              top: 0,
                              left: 16,
                              right: 16,
                              bottom: 16,
                            ),
                            child: SvgPicture.string(
                              state.card.id.barcode(300, 60),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          case CardWithoutData:
            return Container();
        }
        return const SizedBox();
      },
    );
  }

  Widget _getDetail(CardModel card) {
    return Card(
      margin: const EdgeInsets.only(
        top: 172,
        left: 2,
        right: 2,
      ),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.white,
      child: SizedBox(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SliderRank(
                preRankName: card.rankName,
                nextRankName: card.nextRankName,
                maxProgress: card.nextRank,
                progress: card.scores,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Còn ${card.nextRank - card.scores} BEAN nữa bạn sẽ thăng hạng.',
              style: const TextStyle(fontSize: 13),
            ),
            const Text(
              'Đổi quà không ảnh hưởng đến việc thăng hạng của bạn',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 2),
            Text(
              card.status,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _getInfo(CardModel? card) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black54.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card != null ? card.name.toUpperCase() : '',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '${card != null ? card.scores : '0'} BEAN - ${card != null ? card.rankName : ''}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}

class SliderRank extends StatelessWidget {
  final String preRankName;
  final String nextRankName;
  final int maxProgress;
  final int progress;

  const SliderRank({
    Key? key,
    required this.preRankName,
    required this.nextRankName,
    required this.maxProgress,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.85;
    var widthSlider = width > 24 ? width - 24 : 0;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(preRankName), Text(nextRankName)],
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: width,
              height: 10,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: widthSlider * (progress.toDouble() / maxProgress),
              ),
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 2, color: Colors.orange),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.eco,
                color: Colors.orange,
                size: 18,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: width - 8),
              child: Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
