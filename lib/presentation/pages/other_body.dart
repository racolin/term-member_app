import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/home_cubit.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/feature_card_widget.dart';
import 'package:member_app/presentation/widgets/group_item_widget.dart';

import '../../business_logic/cubits/voucher_cubit.dart';
import '../res/dimen/dimens.dart';
import '../screens/voucher_screen.dart';

class OtherBody extends StatelessWidget {
  final bool login;

  const OtherBody({
    Key? key,
    this.login = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            _getMedias(context),
            _getSupports(context),
            _getAccounts(context),
            const SizedBox(height: dimLG),
          ],
        ),
      ),
    );
  }

  Widget _getMedias(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(spaceXS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: spaceSM,
            ),
            child: Text(
              txtMedia,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontLG,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: FeatureCardWidget(
                  icon: Icons.description_outlined,
                  iconColor: Colors.orange,
                  title: txtYourVoucher,
                  onClick: () {
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
                ),
              ),
            ],
          ),
          const SizedBox(height: spaceXS),
          Row(
            children: [
              Expanded(
                child: FeatureCardWidget(
                  icon: Icons.shopping_cart_checkout_outlined,
                  iconColor: Colors.green,
                  title: txtCartTemplate,
                  onClick: () {
                    if (login) {
                      Navigator.pushNamed(context, AppRouter.cartTemplate);
                    } else {
                      Navigator.pushNamed(context, AppRouter.auth);
                    }
                  },
                ),
              ),
              const SizedBox(width: spaceXS),
              Expanded(
                child: FeatureCardWidget(
                  icon: Icons.local_police_outlined,
                  iconColor: Colors.purple,
                  title: txtRules,
                  onClick: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getAccounts(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(spaceXS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: spaceSM,
            ),
            child: Text(
              txtAccount,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontLG,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(spaceXS),
            ),
            child: Column(
              children: [
                GroupItemWidget(
                  icon: const Icon(
                    Icons.person_outline_outlined,
                    size: fontLG,
                    color: Colors.black,
                  ),
                  title: txtPersonalInfo,
                  onClick: () {
                    if (login) {
                      Navigator.pushNamed(context, AppRouter.profile);
                    } else {
                      Navigator.pushNamed(context, AppRouter.auth);
                    }
                  },
                  isTop: true,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: spaceMD),
                  child: Divider(height: 1),
                ),
                GroupItemWidget(
                  icon: const Icon(
                    Icons.bookmark_border_outlined,
                    size: fontLG,
                    color: Colors.black,
                  ),
                  title: txtSavedAddress,
                  onClick: () {
                    if (login) {
                      Navigator.pushNamed(context, AppRouter.address);
                    } else {
                      Navigator.pushNamed(context, AppRouter.auth);
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: spaceMD),
                  child: Divider(height: 1),
                ),
                GroupItemWidget(
                  icon: const Icon(
                    Icons.settings_outlined,
                    size: fontLG,
                    color: Colors.black,
                  ),
                  title: txtSetting,
                  onClick: () {
                    if (login) {
                      Navigator.pushNamed(context, AppRouter.setting);
                    } else {
                      Navigator.pushNamed(context, AppRouter.auth);
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: spaceMD),
                  child: Divider(height: 1),
                ),
                GroupItemWidget(
                  icon: const Icon(
                    Icons.logout_outlined,
                    size: fontLG,
                    color: Colors.black,
                  ),
                  title: login ? txtLogOut : txtLogIn,
                  onClick: () {
                    if (login) {
                      showCupertinoDialog(
                        context: context,
                        builder: (ctx) => AppDialog(
                          message: AppMessage(
                            type: AppMessageType.notify,
                            title: txtLogOut,
                            content: txtConfirmLogOut,
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text(txtNo),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text(txtYes),
                              onPressed: () async {
                                var message = await BlocProvider.of<HomeCubit>(
                                  context,
                                ).logout();
                                // clear data here
                                if (context.mounted) {
                                  if (message == null) {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRouter.auth,
                                      (route) => false,
                                    );
                                  } else {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return AppDialog(
                                          message: message,
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text(txtConfirm),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      Navigator.pushNamed(context, AppRouter.auth);
                    }
                  },
                  isBottom: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getSupports(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(spaceXS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: spaceSM,
            ),
            child: Text(
              txtSupport,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontLG,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(spaceXS),
            ),
            child: Column(
              children: [
                GroupItemWidget(
                  icon: const Icon(
                    Icons.star_outline_outlined,
                    size: fontLG,
                    color: Colors.black,
                  ),
                  title: txtHistoryOrder,
                  onClick: () {
                    if (login) {
                      Navigator.pushNamed(context, AppRouter.carts);
                    } else {
                      Navigator.pushNamed(context, AppRouter.auth);
                    }
                  },
                  isTop: true,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: spaceMD),
                  child: Divider(height: 1),
                ),
                GroupItemWidget(
                  icon: const Icon(
                    Icons.messenger_outline_outlined,
                    size: fontLG,
                    color: Colors.black,
                  ),
                  title: txtContactTile,
                  onClick: () {},
                  isBottom: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
