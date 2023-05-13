import 'package:flutter/material.dart';

import '../../data/models/voucher_model.dart';
import '../../supports/convert.dart';
import '../clippers/ticket_clipper.dart';
import '../res/dimen/dimens.dart';
import 'app_image_widget.dart';

class VoucherWidget extends StatelessWidget {
  final VoucherModel voucher;
  final VoidCallback? onClick;
  final double height = 100;
  final int numberOfSmall = 8;
  final int rateLeft = 2;
  final int rateRight = 5;

  const VoucherWidget({
    Key? key,
    required this.voucher,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: ClipPath(
        clipper: TicketClipper(
          numberOfSmall: numberOfSmall,
          ticketRate: rateLeft / (rateLeft + rateRight),
        ),
        child: Container(
          height: height,
          color: Colors.white70,
          child: Row(
            children: [
              Expanded(
                flex: rateLeft,
                child: Padding(
                  padding: const EdgeInsets.all(spaceSM),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(spaceXS),
                    child: AppImageWidget(image: voucher.image),
                  ),
                ),
              ),
              Expanded(
                flex: rateRight,
                child: Padding(
                  padding: const EdgeInsets.all(spaceMD),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        voucher.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        dateToString(voucher.to, 'dd/MM/yyyy'),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
