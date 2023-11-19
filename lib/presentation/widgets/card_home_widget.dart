import 'package:flutter/material.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';

class CardHomeWidget extends StatelessWidget {
  const CardHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(spaceXS),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(spaceXS),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: spaceXS,
          ),
          Text(
            txtRightOfMember,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(
            height: spaceXXS,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: spaceMD),
            child: Text(
              txtRequireLogin1,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(spaceSM),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/card_background_no_auth.png',
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 168,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.auth);
                    },
                    child: const Text(
                      txtLogIn,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(
                    bottom: 6,
                    left: spaceXS,
                    right: spaceXS,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(spaceXXS),
                  ),
                  child: ListTile(
                    dense: true,
                    visualDensity: VisualDensity.comfortable,
                    contentPadding: const EdgeInsets.symmetric(horizontal: spaceSM),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(spaceXS),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.reward);
                    },
                    title: Text(
                      txtReward,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
