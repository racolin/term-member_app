import 'package:flutter/material.dart';
import 'package:member_app/data/models/promotion_model.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/promotion_category_model.dart';
import 'package:member_app/presentation/widgets/promotion_large_widget.dart';
import 'package:member_app/presentation/widgets/promotion_me_widget.dart';
import 'package:member_app/presentation/widgets/promotion_small_widget.dart';

import 'group_item_widget.dart';

class PromotionSwapWidget extends StatelessWidget {
  final VoidCallback toRedeemVoucherPage;

  const PromotionSwapWidget({
    Key? key,
    required this.toRedeemVoucherPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = [
      PromotionCategory(
        id: '1',
        title: 'Tất cả',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategory(
        id: '2',
        title: 'The Coffee House',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategory(
        id: '3',
        title: 'Ăn uống',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategory(
        id: '4',
        title: 'Du lịch',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategory(
        id: '5',
        title: 'Mua sắm',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategory(
        id: '6',
        title: 'Giải trí',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategory(
        id: '7',
        title: 'Dịch vụ',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
      PromotionCategory(
        id: '8',
        title: 'Giới hạn',
        image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
      ),
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              txtOutStanding,
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
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
                  (e) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PromotionLargeWidget(
                        promotion: e,
                      ),
                      const SizedBox(
                        width: spaceXS,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: spaceMD,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              txtFromMe,
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
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
                  (e) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PromotionMeWidget(
                        promotion: e,
                      ),
                      const SizedBox(
                        width: spaceXS,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: spaceMD,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              txtFromPartner,
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _getFromPartner(
            List.generate(
              11,
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
            ),
            3,
          ),
        ),
        const SizedBox(
          height: spaceMD,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              txtFromPartner,
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
        Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(spaceXS),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < list.length; i++)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GroupItemWidget(
                      icon: const Icon(
                        Icons.star_outline_outlined,
                        size: fontLG,
                        color: Colors.black,
                      ),
                      title: list[i].title,
                      onClick: () {},
                      isTop: i == 0,
                      isBottom: i == list.length - 1,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: spaceMD),
                      child: Divider(height: 1),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(
          height: dimLG,
        ),
      ],
    );
  }

  Widget _getFromPartner(
    List<PromotionModel> promotions,
    int itemInColumn,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < promotions.length; i += itemInColumn)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getItemFromPartner(
                promotions.sublist(
                  i,
                  (i + itemInColumn) > promotions.length
                      ? promotions.length
                      : (i + itemInColumn),
                ),
              ),
              const SizedBox(
                width: spaceXS,
              ),
            ],
          ),
      ],
    );
  }

  Widget _getItemFromPartner(List<PromotionModel> promotions) {
    return SizedBox(
      width: 280,
      child: Column(
        children: promotions
            .map(
              (promotion) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PromotionSmallWidget(
                    promotion: promotion,
                  ),
                  const SizedBox(
                    height: spaceXS,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
