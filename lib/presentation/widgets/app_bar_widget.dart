import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/cart_cubit.dart';
import 'package:member_app/business_logic/cubits/cart_template_cubit.dart';
import 'package:member_app/business_logic/cubits/voucher_cubit.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/presentation/screens/product_search_screen.dart';
import 'package:member_app/presentation/screens/product_favorite_screen.dart';
import 'package:member_app/presentation/screens/voucher_screen.dart';

import '../../business_logic/blocs/interval/interval_bloc.dart';
import '../../business_logic/cubits/home_cubit.dart';
import '../../data/models/app_bar_model.dart';
import '../../data/models/product_model.dart';
import '../../presentation/widgets/app_image_widget.dart';
import '../../business_logic/cubits/product_cubit.dart';
import '../../business_logic/cubits/product_scroll_cubit.dart';
import '../../business_logic/states/home_state.dart';
import '../../presentation/res/dimen/dimens.dart';
import '../../business_logic/cubits/app_bar_cubit.dart';
import '../../business_logic/states/app_bar_state.dart';
import '../res/strings/values.dart';
import '../screens/cart_template_screen.dart';
import 'product/product_categories_widget.dart';
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
    return BlocBuilder<AppBarCubit, AppBarState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case AppBarInitial:
          case AppBarLoading:
            return AppBar();
          case AppBarLoaded:
            state as AppBarLoaded;
            return _AppBarWidget(
              appBar: state.appBar,
            );
        }
        return AppBar(
          backgroundColor: Colors.black87,
        );
      },
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  final AppBarModel appBar;

  const _AppBarWidget({
    Key? key,
    required this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeInitial:
            return AppBar();
          case HomeLoading:
            return AppBar();
          case HomeLoaded:
            state as HomeLoaded;
            switch (state.type) {
              case HomeBodyType.home:
                return AppBar(
                  elevation: 1,
                  backgroundColor: Theme.of(context).primaryColor,
                  title: Row(
                    children: [
                      GreetingWidget(
                        image: appBar.image,
                        label: appBar.greeting,
                      ),
                      const Spacer(),
                      BaseActionWidget(
                        login: state.login,
                        cartTemplateAmount: appBar.cartTemplateAmount,
                        notifyAmount: appBar.notifyAmount,
                        voucherAmount: appBar.voucherAmount,
                      ),
                    ],
                  ),
                );
              case HomeBodyType.order:
                return AppBar(
                  elevation: 1,
                  backgroundColor: Colors.white,
                  title: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (ctx) {
                              return BlocProvider<ProductCubit>.value(
                                value: context.read<ProductCubit>(),
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(bottom: spaceXXL),
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
                                      ProductCategoriesWidget(
                                        maxItem: 100,
                                        scrollTo: (index) {
                                          context
                                              .read<ProductScrollCubit>()
                                              .setIndex(index);
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
                              txtOrder,
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
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            spaceLG,
                          ),
                        ),
                        child: InkWell(
                          overlayColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor.withOpacity(opaSM),
                          ),
                          borderRadius: BorderRadius.circular(spaceLG),
                          radius: 40,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) {
                                  return MultiRepositoryProvider(
                                    providers: [
                                      BlocProvider<ProductCubit>.value(
                                        value: BlocProvider.of<ProductCubit>(
                                          context,
                                        ),
                                      ),
                                      BlocProvider<HomeCubit>.value(
                                        value: BlocProvider.of<HomeCubit>(
                                          context,
                                        ),
                                      ),
                                      BlocProvider<CartCubit>.value(
                                        value: BlocProvider.of<CartCubit>(
                                          context,
                                        ),
                                      ),
                                      BlocProvider<IntervalBloc<ProductModel>>(
                                        create: (ctx) =>
                                            IntervalBloc<ProductModel>(
                                          submit: BlocProvider.of<ProductCubit>(
                                              ctx),
                                        ),
                                      ),
                                    ],
                                    child:
                                        ProductSearchScreen(onClick: (model) {
                                      Navigator.pop(context);
                                    }),
                                  );
                                },
                              ),
                            );
                          },
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
                          borderRadius: BorderRadius.circular(spaceLG),
                        ),
                        child: InkWell(
                          overlayColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor.withOpacity(opaSM),
                          ),
                          borderRadius: BorderRadius.circular(spaceLG),
                          radius: 40,
                          onTap: () {
                            if (!state.login) {
                              Navigator.pushNamed(context, AppRouter.auth);
                            } else {
                              // showCupertinoDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return const LoadingDialog();
                              //   },
                              // );
                              // context.read<ProductCubit>().loadFavorites().then(
                              //   (message) {
                              //     Navigator.pop(context);
                              //     if (message == null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) {
                                          return MultiRepositoryProvider(
                                            providers: [
                                              BlocProvider<ProductCubit>.value(
                                                value: BlocProvider.of<
                                                    ProductCubit>(
                                                  context,
                                                ),
                                              ),
                                              BlocProvider<HomeCubit>.value(
                                                value:
                                                    BlocProvider.of<HomeCubit>(
                                                  context,
                                                ),
                                              ),
                                              BlocProvider<CartCubit>.value(
                                                value:
                                                    BlocProvider.of<CartCubit>(
                                                  context,
                                                ),
                                              ),
                                            ],
                                            child:
                                                const ProductFavoriteScreen(),
                                          );
                                        },
                                      ),
                                    );
                              //     } else {
                              //       showCupertinoDialog(
                              //         context: context,
                              //         builder: (context) {
                              //           return AppDialog(
                              //             message: message,
                              //             actions: [
                              //               CupertinoDialogAction(
                              //                 child: const Text(
                              //                   txtConfirm,
                              //                 ),
                              //                 onPressed: () {
                              //                   Navigator.pop(context);
                              //                 },
                              //               ),
                              //             ],
                              //           );
                              //         },
                              //       );
                              //     }
                              //   },
                              // );
                            }
                          },
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
                      ),
                    ],
                  ),
                );
              case HomeBodyType.store:
                return AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: Row(
                    children: [
                      Text(
                        txtStore,
                        style: TextStyle(
                          fontSize: fontLG,
                          color: Colors.black.withAlpha(200),
                        ),
                      ),
                      const Spacer(),
                      BaseActionWidget(
                        login: state.login,
                        cartTemplateAmount: appBar.cartTemplateAmount,
                        notifyAmount: appBar.notifyAmount,
                        voucherAmount: appBar.voucherAmount,
                      ),
                    ],
                  ),
                );
              case HomeBodyType.promotion:
                return AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: Row(
                    children: [
                      Text(
                        txtPromotion,
                        style: TextStyle(
                          fontSize: fontLG,
                          color: Colors.black.withAlpha(200),
                        ),
                      ),
                      const Spacer(),
                      BaseActionWidget(
                        login: state.login,
                        cartTemplateAmount: appBar.cartTemplateAmount,
                        notifyAmount: appBar.notifyAmount,
                        voucherAmount: appBar.voucherAmount,
                      ),
                    ],
                  ),
                );
              case HomeBodyType.other:
                return AppBar(
                  elevation: 1,
                  backgroundColor: Colors.white,
                  title: Row(
                    children: [
                      Text(
                        txtOther,
                        style: TextStyle(
                          fontSize: fontLG,
                          color: Colors.black.withAlpha(200),
                        ),
                      ),
                      const Spacer(),
                      BaseActionWidget(
                        login: state.login,
                        cartTemplateAmount: appBar.cartTemplateAmount,
                        notifyAmount: appBar.notifyAmount,
                        voucherAmount: appBar.voucherAmount,
                      ),
                    ],
                  ),
                );
            }
        }
        return AppBar();
      },
    );
  }
}

class BaseActionWidget extends StatelessWidget {
  final bool login;
  final int cartTemplateAmount;
  final int voucherAmount;
  final int notifyAmount;

  const BaseActionWidget({
    Key? key,
    required this.login,
    required this.cartTemplateAmount,
    required this.notifyAmount,
    required this.voucherAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!context.read<HomeCubit>().login) {
      return const SizedBox();
    }
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(spaceLG),
          ),
          child: InkWell(
            overlayColor: MaterialStateProperty.all(
              Theme.of(context).primaryColor.withOpacity(opaSM),
            ),
            borderRadius: BorderRadius.circular(spaceLG),
            radius: 40,
            onTap: () {
              if (login) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) {
                      return const CartTemplateScreen();
                    },
                  ),
                );
              } else {
                Navigator.pushNamed(context, AppRouter.auth);
              }
            },
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
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -4, end: -4),
                badgeContent: Text(
                  cartTemplateAmount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: fontXS,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.red,
                ),
                stackFit: StackFit.expand,
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
              Theme.of(context).primaryColor.withOpacity(opaSM),
            ),
            elevation: MaterialStateProperty.all(2),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(spaceLG),
              ),
            ),
          ),
          onPressed: () {
            if (login) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return BlocProvider<VoucherCubit>.value(
                      value: BlocProvider.of<VoucherCubit>(context),
                      child: const VoucherScreen(),
                    );
                  },
                ),
              );
            } else {
              Navigator.pushNamed(context, AppRouter.auth);
            }
          },
          icon: const Icon(
            Icons.confirmation_number_outlined,
            size: fontXL,
            color: Colors.orange,
          ),
          label: Text(
            voucherAmount.toString(),
            style: TextStyle(
              fontSize: 16,
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
              Theme.of(context).primaryColor.withOpacity(opaSM),
            ),
            radius: 40,
            onTap: () {
              if (login) {
                Navigator.pushNamed(context, AppRouter.notify);
              } else {
                Navigator.pushNamed(context, AppRouter.auth);
              }
            },
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
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -4, end: -4),
                badgeContent: Text(
                  notifyAmount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: fontXS,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.red,
                ),
                stackFit: StackFit.expand,
                child: Icon(
                  Icons.notifications_outlined,
                  size: fontXL,
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

class GreetingWidget extends StatelessWidget {
  final String? image;
  final String label;

  const GreetingWidget({
    Key? key,
    required this.image,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppImageWidget(
          image: image,
          height: dimXS,
          width: dimXS,
          borderRadius: BorderRadius.circular(dimXS / 2),
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
      ],
    );
  }
}
