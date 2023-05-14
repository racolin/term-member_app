import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/loading_page.dart';
import '../res/strings/values.dart';
import '../../business_logic/cubits/notify_cubit.dart';
import '../../business_logic/states/notify_state.dart';
import '../res/dimen/dimens.dart';
import '../widgets/notify_widget.dart';

class NotifyScreen extends StatelessWidget {
  const NotifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: spaceXL,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: Text(
          txtNotify,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.orange.withAlpha(50),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 28,
            icon: const Icon(
              Icons.done_all_outlined,
              size: 18,
            ),
          ),
        ],
      ),
      body: BlocBuilder<NotifyCubit, NotifyState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case NotifyInitial:
              return const SizedBox();
            case NotifyLoading:
              return const LoadingPage();
            case NotifyLoaded:
              state as NotifyLoaded;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...state.list
                        .map((notify) => NotifyWidget(notify: notify))
                        .toList(),
                    const SizedBox(
                      height: dimMD,
                    ),
                  ],
                ),
              );
          }
          return const LoadingPage();
        },
      ),
    );
  }
}
