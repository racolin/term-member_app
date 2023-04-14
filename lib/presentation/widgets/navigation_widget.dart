import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/cubits/app_bar_cubit.dart';
import '../business_logic/cubits/home_cubit.dart';
import '../business_logic/cubits/home_state.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({Key? key}) : super(key: key);

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, int>(
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: (index) {
            context.read<HomeCubit>().setBody(HomeBodyType.values[index]);
            context.read<AppBarCubit>().setAppBar(HomeBodyType.values[index]);
          },
          currentIndex: state,
          unselectedItemColor: Colors.grey,
          selectedFontSize: fontXS,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          unselectedFontSize: fontXS,
          selectedItemColor: primaryColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.other_houses_outlined),
              tooltip: txtEHome,
              label: txtHome,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_food_beverage_outlined),
              tooltip: txtEOrder,
              label: txtOrder,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront),
              tooltip: txtEStore,
              label: txtStore,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number_outlined),
              tooltip: txtEPromotion,
              label: txtPromotion,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.reorder),
              tooltip: txtEOther,
              label: txtOther,
            ),
          ],
        );
      },
      selector: (state) => state.homeBodyType.index,
    );
  }
}
