import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../data/models/promotion_model.dart';
import '../res/dimen/dimens.dart';

class PromotionMeWidget extends StatelessWidget {
  final PromotionModel promotion;
  final double size = 160;

  const PromotionMeWidget({
    Key? key,
    required this.promotion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Stores main'),);
    // return GestureDetector(
    //   onTap: () {},
    //   child: SizedBox(
    //     width: size,
    //     child: Card(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(spaceXS),
    //       ),
    //       margin: EdgeInsets.zero,
    //       child: Column(
    //         children: [
    //           ClipRRect(
    //             borderRadius: const BorderRadius.vertical(
    //               top: Radius.circular(spaceXS),
    //             ),
    //             child: Image.network(
    //               promotion.image,
    //               fit: BoxFit.cover,
    //               height: size,
    //               width: size,
    //             ),
    //           ),
    //           const SizedBox(
    //             height: spaceXS,
    //           ),
    //           CircleAvatar(
    //             radius: spaceSM,
    //             child: Image.network(
    //               'https://cdn-icons-png.flaticon.com/512/680/680391.png',
    //             ),
    //           ),
    //           const SizedBox(
    //             height: spaceXS,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: spaceXS),
    //             child: Text(
    //               promotion.description,
    //               maxLines: 2,
    //               textAlign: TextAlign.center,
    //               overflow: TextOverflow.ellipsis,
    //               style: const TextStyle(
    //                 fontSize: fontMD,
    //               ),
    //             ),
    //           ),
    //           const SizedBox(
    //             height: spaceXS,
    //           ),
    //           IntrinsicWidth(
    //             child: Container(
    //               padding: const EdgeInsets.symmetric(horizontal: spaceMD, vertical: spaceXXS),
    //               alignment: Alignment.center,
    //               decoration: BoxDecoration(
    //                 color: Colors.blue,
    //                 borderRadius: BorderRadius.circular(spaceMD),
    //               ),
    //               child: Text(
    //                 promotion.score.toString(),
    //                 style: const TextStyle(
    //                   fontWeight: FontWeight.w700,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           const SizedBox(
    //             height: spaceXS,
    //           ),
    //           const Text(
    //             txtPointName,
    //             style: TextStyle(
    //               color: Colors.black87,
    //             ),
    //           ),
    //           const SizedBox(
    //             height: spaceXS,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
