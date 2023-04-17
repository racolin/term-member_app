import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubits/news_cubit.dart';
import '../../business_logic/states/news_state.dart';
import '../../presentation/widgets/news_widget.dart';

import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';

class NewsSectionWidget extends StatefulWidget {
  const NewsSectionWidget({Key? key}) : super(key: key);

  @override
  State<NewsSectionWidget> createState() => _NewsSectionWidgetState();
}

class _NewsSectionWidgetState extends State<NewsSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case NewsInitial:
            return const SizedBox();
          case NewsLoading:
            return const SizedBox();
          case NewsLoaded:
            state as NewsLoaded;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: spaceXS,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: spaceXS,
                    vertical: spaceXXS,
                  ),
                  child: Text(
                    txtNews,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: fontLG,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: spaceXS),
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      for (int i = 0; i < state.list.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                  horizontal: spaceSM,
                                ),
                              ),
                              overlayColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor.withOpacity(opaMD),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                state.index == i
                                    ? Theme.of(context)
                                        .primaryColor
                                        .withOpacity(opaSM)
                                    : Colors.white.withOpacity(opaSM),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(spaceLG),
                                ),
                              ),
                            ),
                            onPressed: () {
                              context.read<NewsCubit>().setIndex(i);
                            },
                            child: Text(
                              state.list[i].name,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                NewsWidget(
                  newsList: state.list[state.index].items,
                ),
              ],
            );
        }
        return const SizedBox();
      },
    );
  }
}
