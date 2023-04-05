import 'package:flutter/material.dart';
import 'package:member_app/data/models/promotion_model.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/card_widget.dart';
import 'package:member_app/presentation/widgets/promotion_small_widget.dart';
import 'package:member_app/presentation/widgets/ticket_widget.dart';

import '../../data/models/ticket_model.dart';
import 'feature_card_widget.dart';

class PromotionPointWidget extends StatelessWidget {
  const PromotionPointWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CardWidget(
          isDetail: true,
        ),
        _getFeatures(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              txtYourTicket,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontLG,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigator.pushNamed(context, VouchersPage.routeName);
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                  Colors.orange.withOpacity(opaXS),
                ),
                backgroundColor: MaterialStateProperty.all(
                  Colors.orange.withAlpha(20),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(spaceLG),
                  ),
                ),
              ),
              child: const Text(
                txtSeeAll,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            5,
            (index) => TicketModel(
              id: 'FREESHIP2023$index',
              image:
                  'https://stc.shopiness.vn/deal/2020/02/06/6/2/e/1/1580963857029_540.png',
              title: 'Giảm 20K đơn 50K',
              from: DateTime(2023, 3, 0),
              expire: DateTime(2023, 3, 29),
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
            ),
          )
              .map(
                (e) => Column(
                  children: [
                    TicketWidget(
                      ticket: e,
                    ),
                    const SizedBox(
                      height: spaceXS,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
        const SizedBox(
          height: spaceMD,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              txtPromotionSwap,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontLG,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.orange.withAlpha(20),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(spaceMD),
                  ),
                ),
              ),
              child: const Text(
                txtSeeAll,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            7,
            (index) => PromotionModel(
              id: 'PM-0$index',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              partner: 'Beauty Garden',
              title: 'Giảm 50.000đ cho đơn 199.000đ',
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
              expire: DateTime(2023, 3, 29),
              userFor: 86400 * 30,
              score: 99,
            ),
          )
              .map(
                (e) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PromotionSmallWidget(
                      promotion: e,
                    ),
                    const SizedBox(
                      height: spaceXS,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
        const SizedBox(
          height: dimLG,
        ),
      ],
    );
  }

  Widget _getFeatures() {
    return Container(
      margin: const EdgeInsets.only(top: spaceXXS, bottom: spaceMD),
      child: Column(
        children: [
          const SizedBox(
            height: spaceMD,
          ),
          Row(
            children: [
              Expanded(
                child: FeatureCardWidget(
                  iconColor: Colors.green,
                  icon: Icons.energy_savings_leaf_outlined,
                  title: txtPromotionSwap,
                  onClick: () {},
                ),
              ),
              const SizedBox(width: spaceXS),
              Expanded(
                child: FeatureCardWidget(
                  iconColor: Colors.orange,
                  icon: Icons.confirmation_number_outlined,
                  title: txtYourVoucher,
                  onClick: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: spaceXS),
          Row(
            children: [
              Expanded(
                child: FeatureCardWidget(
                  iconColor: Colors.amber,
                  icon: Icons.history_edu,
                  title: '$txtHistory $txtScoreName',
                  onClick: () {},
                ),
              ),
              const SizedBox(width: spaceXS),
              Expanded(
                child: FeatureCardWidget(
                  iconColor: Colors.blue,
                  icon: Icons.admin_panel_settings_outlined,
                  title: txtYourRight,
                  onClick: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
