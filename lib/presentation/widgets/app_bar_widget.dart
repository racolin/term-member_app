import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return _getAppbar(context);
  }

  Widget _getTitle() {
    return Row(
      children: [
        Container(
          width: dimXS,
          height: dimXS,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dimSM / 2),
            color: Colors.orange,
          ),
          child: const Icon(
            Icons.emoji_food_beverage,
            size: fontLG,
          ),
        ),
        const SizedBox(
          width: spaceXS,
        ),
        Text(
          'Chúc ngủ ngon!',
          style: TextStyle(
            fontSize: fontMD,
            color: Colors.black.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _getAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange.withAlpha(50),
      elevation: 0,
      title: Row(
        children: [
          _getTitle(),
          const Spacer(),
          _getAction(context),
        ],
      ),
    );
  }

  Widget _getAction(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            radius: 40,
            onTap: () {},
            child: Ink(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 1),
                    blurRadius: 1.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Badge(
                position: const BadgePosition(top: -4, end: -4),
                badgeContent: const Text(
                  '0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                badgeColor: Colors.red,
                child: Icon(
                  Icons.shopping_cart_checkout_outlined,
                  size: 24,
                  color: Colors.black.withAlpha(200),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        TextButton.icon(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(2),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: () {},
          icon: const Icon(
            Icons.confirmation_number_outlined,
            size: 24,
            color: Colors.orange,
          ),
          label: Text(
            '0',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black.withAlpha(200),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            radius: 40,
            onTap: () {},
            child: Ink(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 1),
                    blurRadius: 1.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Badge(
                position: const BadgePosition(top: -4, end: -4),
                badgeContent: const Text(
                  '0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                badgeColor: Colors.red,
                child: Icon(
                  Icons.notifications_outlined,
                  size: 24,
                  color: Colors.black.withAlpha(200),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
