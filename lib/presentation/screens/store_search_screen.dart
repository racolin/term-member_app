import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/interval/interval_bloc.dart';
import '../animation/typing_animation.dart';
import '../res/dimen/dimens.dart';
import '../../data/models/store_model.dart';
import '../res/strings/values.dart';
import '../widgets/store/store_item_widget.dart';
import '../pages/store_body.dart';

class StoreSearchScreen extends StatefulWidget {
  final Function(StoreModel) onClick;

  const StoreSearchScreen({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  @override
  State<StoreSearchScreen> createState() => _StoreSearchScreenState();
}

class _StoreSearchScreenState extends State<StoreSearchScreen> {
  @override
  void initState() {
    context.read<IntervalBloc<StoreModel>>().add(IntervalSearch(key: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<IntervalBloc<StoreModel>, IntervalState>(
        builder: (context, state) {
          var list = <StoreModel>[];
          if (state is IntervalLoaded<StoreModel>) {
            list = state.list;
          }
          return Column(
            children: [
              _getSearchAddress(context, state),
              Expanded(
                child: Container(
                  color: Colors.grey.withAlpha(50),
                  padding: const EdgeInsets.all(spaceXS),
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) => StoreItemWidget(
                      store: list[index],
                      onClick: widget.onClick,
                    ),
                    padding: const EdgeInsets.only(bottom: dimLG),
                    itemCount: list.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _getSearchAddress(BuildContext context, IntervalState state) {
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
                    suffixIcon: (state is IntervalLoaded && state.reload)
                        ? TypingAnimation(
                            backgroundColor: Colors.grey.shade100,
                            color: Colors.grey.shade400,
                            activeColor: Colors.orange.shade500,
                          )
                        : null,
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                  onChanged: (value) {
                    context.read<IntervalBloc<StoreModel>>().add(
                          IntervalSearch(key: value),
                        );
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
