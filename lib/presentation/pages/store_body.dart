import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/widgets/stores_widget.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';

import '../../business_logic/blocs/store_bloc.dart';
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
            'Các cửa hàng khác',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: StoresWidget(
            searchKey: '',
            onClickItem: (id) {

            },
          ),
        ),
      ],
    );
  }

  Widget _getSearchAddress(BuildContext context) {
    return Hero(
      tag: searchTag,
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => BlocProvider.value(
                          value: context.read<StoreBloc>(),
                          child: StoreSearchPage(onCLick: (String s) {  },),
                        ),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.map_outlined, size: 20),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Bản đồ',
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
