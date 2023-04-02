import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/app_bar_cubit.dart';
import 'package:member_app/business_logic/cubits/app_bar_state.dart';
import 'package:member_app/business_logic/cubits/category_product_cubit.dart';
import 'package:member_app/business_logic/cubits/home_state.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';

import '../../business_logic/cubits/category_scroll_cubit.dart';
import '../res/strings/values.dart';
import 'categories_widget.dart';
import 'drag_bar_widget.dart';

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
                    _getTitle(state.label, state.type),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            spaceLG,
          ),
        ),
        child: InkWell(
          overlayColor: MaterialStateProperty.all(
            Theme.of(context).primaryColor.withOpacity(
              opaSM,
            ),
          ),
          borderRadius: BorderRadius.circular(spaceLG),
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
              borderRadius: BorderRadius.circular(
                spaceLG
              ),
            ),
            child: const Icon(
              Icons.search,
              size: fontLG,
              color: Colors.orange,
            ),
          ),
        ),
      ),
      const SizedBox(width: spaceXXS),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            spaceLG
          ),
        ),
        child: InkWell(
          overlayColor: MaterialStateProperty.all(
            Theme.of(context).primaryColor.withOpacity(
              opaSM,
            ),
          ),
          borderRadius: BorderRadius.circular(spaceLG),
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
              borderRadius: BorderRadius.circular(
                spaceLG,
              ),
            ),
            child: const Icon(
              Icons.favorite_border,
              size: fontLG,
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
          borderRadius: BorderRadius.circular(spaceLG),
        ),
        child: InkWell(
          overlayColor: MaterialStateProperty.all(
            Theme.of(context).primaryColor.withOpacity(
              opaSM,
            ),
          ),
          borderRadius: BorderRadius.circular(spaceLG),
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
              borderRadius: BorderRadius.circular(spaceLG),
            ),
            child: Badge(
              position: const BadgePosition(top: -4, end: -4),
              badgeContent: Text(
                cartTemplateAmount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: fontXS,
                  fontWeight: FontWeight.w700,
                ),
              ),
              badgeColor: Colors.red,
              child: Icon(
                Icons.shopping_cart_checkout_outlined,
                size: fontXL,
                color: Colors.black.withAlpha(200),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: spaceXS),
      TextButton.icon(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            Theme.of(context).primaryColor.withOpacity(
              opaSM,
            ),
          ),
          elevation: MaterialStateProperty.all(2),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(spaceLG),
            ),
          ),
        ),
        onPressed: () {},
        icon: const Icon(
          Icons.confirmation_number_outlined,
          size: fontXL,
          color: Colors.orange,
        ),
        label: Text(
          ticketAmount.toString(),
          style: TextStyle(
            fontSize: fontLG,
            color: Colors.black.withAlpha(150),
          ),
        ),
      ),
      const SizedBox(width: spaceXS),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(spaceLG),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(spaceLG),
          overlayColor: MaterialStateProperty.all(
            Theme.of(context).primaryColor.withOpacity(
                  opaSM,
                ),
          ),
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
              borderRadius: BorderRadius.circular(spaceLG),
            ),
            child: Badge(
              position: const BadgePosition(top: -4, end: -4),
              badgeContent: Text(
                notifyAmount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: fontXS,
                  fontWeight: FontWeight.w700,
                ),
              ),
              badgeColor: Colors.red,
              child: Icon(
                Icons.notifications_outlined,
                size: fontXL,
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

  Widget _getTitle(
    String label,
    HomeBodyType type,
  ) {
    if (type == HomeBodyType.order) {
      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (ctx) {
              return BlocProvider<CategoryProductCubit>.value(
                value: context.read<CategoryProductCubit>(),
                child: Container(
                  padding: const EdgeInsets.only(bottom: spaceXXL),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(spaceMD),
                    ),
                    color: Colors.white,
                  ),
                  child: Wrap(
                    children: [
                      const DragBarWidget(margin: spaceXS),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: spaceMD,
                        ),
                        child: Text(
                          txtCategory,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: fontLG,
                            color: Colors.black.withAlpha(180),
                          ),
                        ),
                      ),
                      const Divider(),
                      CategoriesWidget(
                        scrollTo: (index) {
                          context.read<CategoryScrollCubit>().setIndex(index);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: fontLG,
                color: Colors.black.withAlpha(200),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Colors.black.withAlpha(200),
              size: fontLG,
            ),
          ],
        ),
      );
    }
    return Text(
      label,
      style: TextStyle(
        fontSize: fontLG,
        color: Colors.black.withAlpha(200),
      ),
    );
  }
}
