import 'package:flutter/material.dart';

import '../../../supports/convert.dart';
import '../../res/dimen/dimens.dart';

class CartProductWidget extends StatelessWidget {
  final int amount;
  final String name;
  final String note;
  final int cost;

  const CartProductWidget({
    Key? key,
    required this.amount,
    required this.name,
    required this.note,
    required this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: spaceMD, bottom: spaceXS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            amount.toString(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: fontMD,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(width: spaceMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: fontMD,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                ...note
                    .split('\n')
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(top: spaceXXS),
                        child: Text(
                          e,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontSize: fontMD,
                                    // fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
          ),
          Text(
            numberToCurrency(cost, 'đ'),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}
