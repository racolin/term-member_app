import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/home_cubit.dart';
import 'package:member_app/business_logic/states/home_state.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/supports/convert.dart';

import '../../data/models/voucher_model.dart';
import '../clippers/vertical_ticket_clipper.dart';

class VoucherBottomSheet extends StatelessWidget {
  final VoucherModel voucher;

  const VoucherBottomSheet({
    Key? key,
    required this.voucher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 1,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          margin: const EdgeInsets.only(top: dimMD),
          padding: const EdgeInsets.all(spaceSM),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(spaceLG),
            color: Colors.orangeAccent,
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(spaceLG),
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(spaceLG),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: spaceLG,
                        ),
                        Text(
                          voucher.partner,
                          style: const TextStyle(
                            fontSize: fontSM,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: spaceXS,
                        ),
                        Text(
                          voucher.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: fontLG,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: spaceLG,
                        ),
                        ClipPath(
                          clipper: VerticalTicketClipper(numberOfSmall: 28),
                          child: Container(
                            height: spaceXS,
                            width: double.maxFinite,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        const SizedBox(height: spaceLG),
                        _getQRCode(voucher.id),
                        const SizedBox(height: spaceMD),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, HomeBodyType.order);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(spaceMD),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.black,
                            ),
                          ),
                          child: const Text(
                            txtOrderStarted,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        _getExpire(),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: spaceMD),
                          child: Text(
                            voucher.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: dimMD,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: fontXL,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getQRCode(String code) {
    return Column(
      children: [
        Image.network(
          'https://vinasupport.com/uploads/2022/05/vinasupport.png',
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: spaceMD,
        ),
        Text(
          code.toUpperCase(),
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w700,
            fontSize: fontMD,
          ),
        ),
        const SizedBox(
          height: spaceXXS,
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.copy,
            color: Colors.orange,
            size: fontLG,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.green.withAlpha(50),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(spaceMD),
              ),
            ),
          ),
          label: const Text(
            txtCopy,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: fontMD,
              color: Colors.black54,
            ),
          ),
        )
      ],
    );
  }

  Widget _getExpire() {
    return Container(
      padding: const EdgeInsets.all(spaceMD),
      child: Column(
        children: [
          const Divider(height: 1),
          const SizedBox(height: spaceMD),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '$txtExpired:',
                style: TextStyle(
                  fontSize: fontMD,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                dateToString(voucher.expire, 'dd/MM/yyyy'),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: fontMD,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: spaceMD),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
