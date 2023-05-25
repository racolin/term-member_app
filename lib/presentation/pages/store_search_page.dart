import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/interval/interval_bloc.dart';
import '../../presentation/res/dimen/dimens.dart';
import '../../data/models/store_model.dart';
import '../res/strings/values.dart';
import '../widgets/store/store_item_widget.dart';
import 'store_body.dart';

class StoreSearchPage extends StatefulWidget {
  final Function(StoreModel) onClick;

  const StoreSearchPage({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  @override
  State<StoreSearchPage> createState() => _StoreSearchPageState();
}

class _StoreSearchPageState extends State<StoreSearchPage> {

  @override
  void initState() {
    context.read<IntervalBloc<StoreModel>>().add(IntervalSearch(key: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _getSearchAddress(context),
          Expanded(
            child: Container(
              color: Colors.grey.withAlpha(50),
              padding: const EdgeInsets.all(spaceXS),
              child: BlocBuilder<IntervalBloc<StoreModel>, IntervalState>(
                builder: (context, state) {
                  var list = <StoreModel>[];
                  if (state is IntervalLoaded<StoreModel>) {
                    list = state.list;
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) => StoreItemWidget(
                      store: list[index],
                      onClick: widget.onClick,
                    ),
                    padding: const EdgeInsets.only(bottom: dimLG),
                    itemCount: list.length,
                  );
                },
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
        color: Theme
            .of(context)
            .primaryColor,
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
                  style: Theme.of(context).textTheme.bodyLarge,
                  onChanged: (value) {
                      context.read<IntervalBloc<StoreModel>>().add(IntervalSearch(key: value));
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
