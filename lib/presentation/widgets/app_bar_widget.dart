import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/app_bar_cubit.dart';
import 'package:member_app/business_logic/cubits/app_bar_state.dart';
import 'package:member_app/business_logic/cubits/home_state.dart';
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
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: BlocBuilder<AppBarCubit, AppBarState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case AppBarInitial:
              break;
            case AppBarLoaded:
              state as AppBarLoaded;
              return Row(
                children: [
                  if (HomeBodyType.home == state.type)
                    ..._getInfoTitle(
                      state.appBar.label,
                      state.appBar.icon,
                    )
                  else
                    _getTitle(state.label),
                  const Spacer(),
                  if (HomeBodyType.order == state.type)
                    ..._getProductAction()
                  else
                    ..._getBaseAction(
                      state.appBar.cartTemplateAmount,
                      state.appBar.ticketAmount,
                      state.appBar.notifyAmount,
                    ),
                ],
              );
          }
          return const SizedBox();
        },
      ),
    );
  }

  List<Widget> _getProductAction() {
    return [
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          radius: 40,
          onTap: () {},
          child: Ink(
            width: 40,
            height: 40,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1),
                blurRadius: 1.0,
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: const Icon(
              Icons.search,
              size: 20,
              color: Colors.orange,
            ),
          ),
        ),
      ),
      const SizedBox(width: 4),
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          radius: 40,
          onTap: () {},
          child: Ink(
            width: 40,
            height: 40,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1),
                blurRadius: 1.0,
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: const Icon(
              Icons.favorite_border,
              size: 20,
              color: Colors.orange,
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> _getBaseAction(
    int cartTemplateAmount,
    int ticketAmount,
    int notifyAmount,
  ) {
    return [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
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
              badgeContent: Text(
                cartTemplateAmount.toString(),
                style: const TextStyle(
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
          ticketAmount.toString(),
          style: TextStyle(
            fontSize: 15,
            color: Colors.black.withAlpha(200),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
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
              badgeContent: Text(
                notifyAmount.toString(),
                style: const TextStyle(
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
    ];
  }

  List<Widget> _getInfoTitle(String label, String icon) {
    return [
      CircleAvatar(
        radius: dimXS / 2,
        backgroundImage: NetworkImage(
          icon,
        ),
      ),
      const SizedBox(
        width: spaceXS,
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: fontMD,
          color: Colors.black.withAlpha(200),
        ),
      )
    ];
  }

  Widget _getTitle(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontLG,
        color: Colors.black.withAlpha(200),
      ),
    );
  }
}
