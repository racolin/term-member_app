import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/widgets/promotion/promotion_small_widget.dart';

import '../../data/models/promotion_model.dart';

class PromotionScreen extends StatelessWidget {
  final List<PromotionModel> promotions;
  final String name;

  const PromotionScreen({
    Key? key,
    required this.promotions,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(fontSize: 16),
        ),
        // backgroundColor: Colors.orange.withAlpha(50),
        // elevation: 0,
        leading: IconButton(
          splashRadius: 28,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: spaceMD,
            bottom: dimMD,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var promotion in promotions)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                  child: PromotionSmallWidget(promotion: promotion),
                ),
            ],
          )),
    );
  }
}
