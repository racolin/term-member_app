import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';

import '../../presentation/res/strings/values.dart';
import '../../data/models/promotion_model.dart';
import '../../supports/convert.dart';
import '../clippers/ticket_clipper.dart';
import '../widgets/app_image_widget.dart';

class PromotionBottomSheet extends StatelessWidget {
  final PromotionModel promotion;
  final Future<AppMessage?> Function() exchange;

  const PromotionBottomSheet({
    Key? key,
    required this.promotion,
    required this.exchange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 1,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(spaceLG),
          ),
          margin: const EdgeInsets.only(top: 56),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(spaceLG),
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(spaceMD),
                            ),
                            child: AppImageWidget(
                              image: promotion.backgroundImage,
                              height: 450,
                              width: double.maxFinite,
                              assetsDefaultImage:
                                  'assets/images/image_default.png',
                            ),
                          ),
                          const SizedBox(height: 56),
                          Card(
                            margin: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 18,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Quy đổi với',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          text: promotion.point.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: ' $txtPointName',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Thời hạn quy đổi',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        promotion.to == null ? 'Không giới hạn' :
                                        dateToString(
                                          promotion.to!,
                                          'dd/MM/yyyy',
                                        ),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 24),
                            child: Text(promotion.description),
                          ),
                          const SizedBox(
                            height: 128,
                          ),
                        ],
                      ),
                      Positioned(
                        top: 400,
                        left: 16,
                        right: 16,
                        child: Container(
                          // height: 96,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.withAlpha(50),
                          ),
                          child: _getTicket(promotion),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  splashRadius: 1,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                    size: 32,
                  ),
                ),
              ),
              Positioned(
                bottom: 32,
                left: 16,
                right: 16,
                child: Card(
                  color: Colors.orange,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Đổi ${promotion.point} $txtPointName \nlấy ưu đãi này',
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            exchange().then(
                              (message) {
                                if (message == null) {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) => AppDialog(
                                      message: AppMessage(
                                        type: AppMessageType.notify,
                                        title: txtNotify,
                                        content:
                                            'Bạn đã đổi khuyến mãi thành công!',
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                            child: const Text(txtConfirm),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    ),
                                  );
                                } else {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) => AppDialog(
                                      message: message,
                                      actions: [
                                        CupertinoDialogAction(
                                          child: const Text(txtConfirm),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Đổi ưu đãi',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getTicket(PromotionModel promotion) {
    return ClipPath(
      clipper: TicketClipper(numberOfSmall: 8, ticketRate: 2 / 7),
      child: Container(
        height: 96,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AppImageWidget(
                    image: promotion.partnerImage,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 0, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      promotion.partner,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      promotion.name,
                      style: const TextStyle(color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
