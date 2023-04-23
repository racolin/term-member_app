import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/presentation/dialogs/dialog_widget.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/feature_card_widget.dart';
import 'package:member_app/presentation/widgets/group_item_widget.dart';

import '../res/dimen/dimens.dart';

class OtherBody extends StatelessWidget {
  final bool login;

  const OtherBody({
    Key? key,
    this.login = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getMedias(),
          _getSupports(),
          _getAccounts(context),
          const SizedBox(height: dimLG),
        ],
      ),
    );
  }

  Widget _getMedias() {
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
                  title: txtHistoryOrder,
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
                  icon: Icons.shopping_cart_checkout_outlined,
                  iconColor: Colors.green,
                  title: txtCartTemplate,
                  onClick: () {},
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
                  onClick: () {},
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
                    Navigator.pushNamed(context, AppRouter.address);
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
                  onClick: () {},
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
                        builder: (context) => DialogWidget(
                          message: AppMessage(
                            type: AppMessageType.info,
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
                              onPressed: () {
                                // clear data here
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRouter.auth,
                                  (route) => false,
                                );
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

  Widget _getSupports() {
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
                  title: txtReviewOrder,
                  onClick: () {},
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
