import 'package:flutter/material.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';

class CardHomeWidget extends StatelessWidget {
  const CardHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(spaceSM),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: spaceSM,
          ),
          Text(
            txtLogIn,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(
            height: spaceSM,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: spaceMD),
            child: Text(
              txtRequireLogin1,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: spaceSM,
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(spaceSM)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/card_background_no_auth.png',
                ),
              ),
            ),
            height: dimXXL,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  margin: const EdgeInsets.all(spaceSM),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(spaceXS),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(spaceXS),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.reward);
                    },
                    title: Text(
                      txtReward,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
