import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:member_app/business_logic/cubits/cart_detail_cubit.dart';
import 'package:member_app/data/models/cart_detail_model.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';

import '../../exception/app_message.dart';
import '../res/strings/values.dart';

class CartReviewShipperBottomSheet extends StatefulWidget {
  final String id;
  final String type;
  final String name;

  const CartReviewShipperBottomSheet({
    Key? key,
    required this.id,
    required this.type,
    required this.name,
  }) : super(key: key);

  @override
  State<CartReviewShipperBottomSheet> createState() =>
      _CartReviewShipperBottomSheetState();
}

class _CartReviewShipperBottomSheetState
    extends State<CartReviewShipperBottomSheet> {
  String rateName = '';
  int? rate;
  String? note;
  Color? color;
  IconData? icon;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 1,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          margin: const EdgeInsets.only(top: dimMD),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(spaceMD),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 55,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(spaceMD),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Đánh giá Shipper',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close_sharp,
                        size: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: spaceXS),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(spaceMD),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.type,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: spaceXS),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: spaceXS),
                  ],
                ),
              ),
              const SizedBox(height: spaceXS),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(spaceMD),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.only(right: 8, left: 0),
                      glow: false,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rate = rating.toInt();
                          switch (rate) {
                            case 0:
                              color = Colors.red;
                              icon = Icons.sentiment_very_dissatisfied_rounded;
                              break;
                            case 1:
                              color = Colors.redAccent;
                              icon = Icons.sentiment_very_dissatisfied_rounded;
                              break;
                            case 2:
                              color = Colors.deepOrange;
                              icon = Icons.sentiment_dissatisfied_rounded;
                              break;
                            case 3:
                              color = Colors.lightGreen;
                              icon = Icons.sentiment_neutral_rounded;
                              break;
                            case 4:
                              color = Colors.green;
                              icon = Icons.sentiment_satisfied_rounded;
                              break;
                            case 5:
                              color = Colors.green;
                              icon = Icons.sentiment_very_satisfied_rounded;
                              break;
                          }
                        });
                      },
                    ),
                    Icon(icon, color: color, size: dimXS),
                  ],
                ),
              ),
              const SizedBox(height: spaceXS),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(spaceMD),
                child: TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: null,
                  onChanged: (value) {
                    note = value;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(spaceXS),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: spaceSM,
                      horizontal: spaceSM,
                    ),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(spaceXS),
                    ),
                    labelText: 'Chia sẻ trải nghiệm của bạn về Shipper',
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: spaceXS),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(spaceMD),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (rate == null) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return AppDialog(
                              message: AppMessage(
                                type: AppMessageType.notify,
                                title: txtNotifyTitle,
                                content: 'Bạn chưa đánh giá Shipper!',
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text(txtConfirm),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                      var message = await context
                          .read<CartDetailCubit>()
                          .reviewShipper(widget.id, rate!, note);
                      if (mounted) {
                        if (message == null) {
                          Navigator.pop(
                            context,
                            CartReviewShipperModel(
                              rate: rate!,
                              review: note,
                            ),
                          );
                        } else {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return AppDialog(
                                message: message,
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text(txtConfirm),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Text(
                      txtSendReview,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
