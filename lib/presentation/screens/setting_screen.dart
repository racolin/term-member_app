import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/feature_card_widget.dart';
import 'package:member_app/presentation/widgets/group_item_widget.dart';

import '../res/dimen/dimens.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var _status = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          txtSetting,
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.orange.withAlpha(50),
        elevation: 0,
        leading: IconButton(
          splashRadius: 28,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: SingleChildScrollView(
        child: _getSettings(context),
      ),
    );
  }

  Widget _getSettings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _getSettingItem(
                    context,
                    const Icon(
                      Icons.notifications_outlined,
                      size: 22,
                      color: Colors.black,
                    ),
                    'Nhận thông báo',
                    () {},
                    1,
                    ItemListTileType.bool),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Divider(height: 1),
                ),
                GroupItemWidget(
                  icon: const Icon(
                    Icons.add_link_outlined,
                    size: fontLG,
                    color: Colors.black,
                  ),
                  title: 'Liên kết tài khoản',
                  onClick: () {},
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Divider(height: 1),
                ),
                GroupItemWidget(
                  icon: const Icon(
                    Icons.add_link_outlined,
                    size: fontLG,
                    color: Colors.black,
                  ),
                  title: 'Về chúng tôi',
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

  Widget _getSettingItem(
    BuildContext context,
    Icon icon,
    String title,
    VoidCallback onClick,
    int position, [
    ItemListTileType type = ItemListTileType.back,
  ]) {
    Widget trailing = type == ItemListTileType.back
        ? const Icon(Icons.chevron_right, color: Colors.grey, size: 16)
        : CupertinoSwitch(
            value: _status,
            onChanged: (value) {
              setState(() {
                _status = value;
              });
            });
    return InkWell(
      borderRadius: position == 0
          ? BorderRadius.zero
          : position > 0
              ? const BorderRadius.vertical(top: Radius.circular(8))
              : const BorderRadius.vertical(bottom: Radius.circular(8)),
      onTap: onClick,
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: trailing,
      ),
    );
  }
}

enum ItemListTileType { back, bool }
