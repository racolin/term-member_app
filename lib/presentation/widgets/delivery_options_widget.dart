import 'package:flutter/material.dart';
import 'package:member_app/presentation/widgets/delivery_option_widget.dart';

import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';

class DeliveryOptionsWidget extends StatelessWidget {
  const DeliveryOptionsWidget({Key? key}) : super(key: key);
  final double height = dimXL;

  @override
  Widget build(BuildContext context) {
      return Container(
        margin: const EdgeInsets.all(spaceXS),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.6)),
          borderRadius: BorderRadius.circular(spaceSM),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DeliveryOptionWidget(
                name: txtOptionDelivery,
                image: 'https://static.vecteezy.com/system/resources/previews/008/492/234/original/delivery-cartoon-illustration-png.png',
                height: height,
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
              child: DeliveryOptionWidget(
                name: txtOptionTake,
                image: 'https://www.drench-design.com/wp-content/uploads/2018/10/coffeetype2.png',
                height: height,
              ),
            ),
          ],
        ),
    );
  }
}
