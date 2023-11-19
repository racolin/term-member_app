import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/card_widget.dart';
import 'package:member_app/presentation/widgets/card_home_widget.dart';
import 'package:member_app/presentation/widgets/card_type_widget.dart';
import 'package:member_app/presentation/widgets/voucher_widget.dart';

import '../../business_logic/cubits/promotion_cubit.dart';
import '../../business_logic/cubits/voucher_cubit.dart';
import '../../business_logic/states/promotion_state.dart';
import '../../business_logic/states/voucher_state.dart';
import '../app_router.dart';
import '../bottom_sheet/voucher_bottom_sheet.dart';
import '../screens/voucher_screen.dart';
import '../widgets/feature_card_widget.dart';
import '../widgets/promotion/promotion_small_widget.dart';

class PromotionPointPage extends StatelessWidget {
  final bool login;

  const PromotionPointPage({
    Key? key,
    this.login = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !login
        ? Column(
            children: const [
              CardHomeWidget(),
              SizedBox(height: spaceXS),
              CardTypeWidget(),
            ],
          )
        : Padding(
            padding: const EdgeInsets.only(
              top: spaceSM,
              left: spaceXS,
              right: spaceXS,
            ),
            child: Column(
              children: [
                const CardWidget(
                  isDetail: true,
                ),
                _getFeatures(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      txtYourVoucher,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: fontLG,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
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
                BlocBuilder<VoucherCubit, VoucherState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case VoucherInitial:
                        return const SizedBox();
                      case VoucherLoading:
                        return const Center(
                          child: LoadingWidget(),
                        );
                      case VoucherLoaded:
                        var list = (state as VoucherLoaded).list;
                        list = list.length > 8 ? list.sublist(0, 8) : list;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: list
                              .sublist(0)
                              .map(
                                (e) => Column(
                                  children: [
                                    VoucherWidget(
                                      voucher: e,
                                      onClick: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) {
                                            return VoucherBottomSheet(
                                              voucher: e,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: spaceXS,
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        );
                    }
                    return const SizedBox();
                  },
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
                BlocBuilder<PromotionCubit, PromotionState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case PromotionInitial:
                        return const SizedBox();
                      case PromotionLoading:
                        return const Center(
                          child: LoadingWidget(),
                        );
                      case PromotionLoaded:
                        var promotions = (state as PromotionLoaded).promotions;
                        promotions = promotions.length > 8
                            ? promotions.sublist(0, 8)
                            : promotions;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: promotions
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
                        );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(
                  height: dimLG,
                ),
              ],
            ),
          );
  }

  Widget _getFeatures(BuildContext context) {
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
                  title: txtAchievement,
                  onClick: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => AppDialog(
                        message: AppMessage(
                          type: AppMessageType.notify,
                          title: txtNotify,
                          content: txtDeveloping,
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text(txtConfirm),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: spaceXS),
              Expanded(
                child: FeatureCardWidget(
                  iconColor: Colors.orange,
                  icon: Icons.confirmation_number_outlined,
                  title: txtYourVoucher,
                  onClick: () {
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
                  },
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
                  title: '$txtHistory $txtPointName',
                  onClick: () {
                    Navigator.pushNamed(context, AppRouter.historyPoint);
                  },
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
