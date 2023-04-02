import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';

import '../res/strings/values.dart';
import 'store_body.dart';
import '../widgets/stores_widget.dart';

class StoreSearchPage extends StatefulWidget {
  final Function(String) onCLick;

  const StoreSearchPage({
    Key? key,
    required this.onCLick,
  }) : super(key: key);

  @override
  State<StoreSearchPage> createState() => _StoreSearchPageState();
}

class _StoreSearchPageState extends State<StoreSearchPage> {
  var searchKey = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _getSearchAddress(context),
          Expanded(
            child: Container(
              color: Colors.grey.withAlpha(50),
              padding: const EdgeInsets.all(8),
              child: StoresWidget(
                searchKey: '',
                onClickItem: (id) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSearchAddress(BuildContext context) {
    return Hero(
      tag: StoreBody.searchTag,
      child: Material(
        color: Theme.of(context).primaryColor,
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: dimMD),
          padding: const EdgeInsets.all(spaceXS),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(spaceXS),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchKey = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: spaceXXS,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(spaceXS),
                child: Container(
                  padding: const EdgeInsets.all(spaceXXS),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(spaceXS),
                  ),
                  child: const Text(
                    txtCancel,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
