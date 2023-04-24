import 'package:flutter/material.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import 'promotion_point_page.dart';
import 'promotion_swap_page.dart';

class PromotionBody extends StatefulWidget {
  final bool login;

  const PromotionBody({Key? key, this.login = false}) : super(key: key);

  @override
  State<PromotionBody> createState() => _PromotionBodyState();
}

class _PromotionBodyState extends State<PromotionBody> {
  var optionIndex = 0;
  Widget _body = Container();
  Widget _point = Container();
  Widget _swap = Container();

  void selectOptionItem(int index) {
    setState(() {
      optionIndex = index;
      if (index == 0) {
        _body = _point;
      } else {
        _body = _swap;
      }
    });
  }

  @override
  void initState() {
    _point = PromotionPointPage(
      login: widget.login,
    );
    _swap = PromotionSwapPage(
      toRedeemVoucherPage: () {
        selectOptionItem(1);
      },
    );
    selectOptionItem(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getOptions(),
        Expanded(
          child: SingleChildScrollView(
            child: _body,
          ),
        ),
      ],
    );
  }

  Widget _getOptions() {
    List<String> options = [
      txtPromotionPoint,
      txtPromotionSwap,
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(spaceXS),
      child: Row(
        children: [
          for (int i = 0; i < options.length; i++)
            InkWell(
              borderRadius: BorderRadius.circular(spaceMD),
              onTap: () {
                if (!widget.login && i == 1) {
                  Navigator.pushNamed(context, AppRouter.auth);
                } else if (optionIndex != i) {
                  selectOptionItem(i);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(spaceMD),
                  color: Colors.orange
                      .withOpacity(i == optionIndex ? opaXXL : opaXS),
                ),
                margin: const EdgeInsets.only(right: spaceXS),
                padding: const EdgeInsets.symmetric(
                  vertical: spaceXS,
                  horizontal: spaceSM,
                ),
                child: Text(
                  options[i],
                  style: TextStyle(
                    color: i == optionIndex ? Colors.white : Colors.orange,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
