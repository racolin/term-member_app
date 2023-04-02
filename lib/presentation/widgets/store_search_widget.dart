import 'package:flutter/material.dart';

import '../../data/models/store_model.dart';
import '../pages/store_body.dart';
import 'store_widget.dart';

class StoreSearchPage extends StatefulWidget {

  const StoreSearchPage({
    Key? key,
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
          Expanded(child: _getListAddress(context, [])),
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
          margin: const EdgeInsets.only(top: 56),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
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
                width: 4,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Huỷ',
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

  Widget _getListAddress(BuildContext context, List<StoreModel> addresses) {
    return Container(
      color: Colors.grey.withAlpha(50),
      padding: const EdgeInsets.all(8),
      child: const StoresWidget(
        searchKey: '',
      ),
    );
  }
}
