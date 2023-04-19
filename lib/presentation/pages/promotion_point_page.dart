import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/card_widget.dart';
import 'package:member_app/presentation/widgets/voucher_widget.dart';

import '../../business_logic/cubits/promotion_cubit.dart';
import '../../business_logic/cubits/voucher_cubit.dart';
import '../../business_logic/states/promotion_state.dart';
import '../../business_logic/states/voucher_state.dart';
import '../widgets/feature_card_widget.dart';
import '../widgets/promotion/promotion_small_widget.dart';

class PromotionPointPage extends StatelessWidget {
  const PromotionPointPage({Key? key}) : super(key: key);

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
              txtYourVoucher,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontLG,
              ),
            ),
            TextButton(
              onPressed: () {},
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (state as VoucherLoaded)
                      .list
                      .map(
                        (e) => Column(
                          children: [
                            VoucherWidget(
                              voucher: e,
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (state as PromotionLoaded)
                      .promotions
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
                  title: '$txtHistory $txtPointName',
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
