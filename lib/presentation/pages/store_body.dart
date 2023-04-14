import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../business_logic/blocs/store_bloc.dart';
import '../../data/models/store_model.dart';
import '../widgets/stores_main_widget.dart';
import 'store_search_widget.dart';

class StoreBody extends StatelessWidget {
  static const String searchTag = 'Search';

  const StoreBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getSearchAddress(context),
        const Padding(
          padding: EdgeInsets.all(spaceSM),
          child: Text(
            txtOtherStore,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: fontLG,
            ),
          ),
        ),
        Expanded(
          child: StoresMainWidget(
            searchKey: '',
            onClickItem: (id) {},
          ),
        ),
      ],
    );
  }

  Widget _getSearchAddress(BuildContext context) {
    return Hero(
      tag: searchTag,
      child: Material(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(spaceXS),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => BlocProvider.value(
                          value: BlocProvider.of<StoreBloc>(context),
                          child: StoreSearchPage(
                            onCLick: (StoreShortModel store) {},
                          ),
                        ),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(spaceXS),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(
                width: spaceXXS,
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(spaceSM),
                child: Container(
                  padding: const EdgeInsets.all(spaceXXS),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(spaceXS),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.map_outlined, size: fontLG),
                      SizedBox(
                        width: spaceXXS,
                      ),
                      Text(
                        txtMap,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
