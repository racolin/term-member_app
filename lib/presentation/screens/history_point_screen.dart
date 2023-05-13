import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../business_logic/cubits/history_point_cubit.dart';
import '../../business_logic/states/history_point_state.dart';
import '../../data/models/history_point_model.dart';
import '../../supports/convert.dart';

class HistoryPointScreen extends StatelessWidget {
  const HistoryPointScreen({Key? key}) : super(key: key);
  static const String routeName = '/Point_history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lịch sửa $txtPointName',
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
      body: BlocBuilder<HistoryPointCubit, HistoryPointState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case HistoryPointInitial:
              return const SizedBox();
            case HistoryPointLoading:
              return const LoadingPage();
            case HistoryPointLoaded:
              var list = (state as HistoryPointLoaded).paging.list;
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) => _getHistoryItem(list[index]),
                itemCount: list.length,
              );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _getHistoryItem(HistoryPointModel model) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 12,
            bottom: 12,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateToString(model.time, 'HH:mm - dd/MM/yyyy'),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      model.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  model.point.toString(),
                  style: TextStyle(
                    color: model.point > 0 ? Colors.green : Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Divider(height: 1),
        ),
      ],
    );
  }
}
