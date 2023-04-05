import 'package:flutter/material.dart';
import 'package:member_app/data/models/promotion_model.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../res/dimen/dimens.dart';

class PromotionLargeWidget extends StatelessWidget {
  final PromotionModel promotion;
  final double size = 280;

  const PromotionLargeWidget({
    Key? key,
    required this.promotion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: size,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(spaceXS),
          ),
          margin: EdgeInsets.zero,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(spaceXS),
                ),
                child: Image.network(
                  promotion.image,
                  fit: BoxFit.cover,
                  height: size,
                  width: size,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(spaceMD),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            promotion.partner,
                            style: const TextStyle(
                              fontSize: fontMD,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: spaceXXS,
                          ),
                          Text(
                            promotion.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: fontMD,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: dimMD,
                          padding: const EdgeInsets.all(spaceXXS),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(spaceMD),
                          ),
                          child: Text(
                            promotion.score.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: spaceXS,
                        ),
                        const Text(
                          txtScoreName,
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
