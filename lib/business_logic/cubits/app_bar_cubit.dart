import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/app_bar_model.dart';
import 'package:member_app/business_logic/cubits/app_bar_state.dart';
import 'package:member_app/business_logic/cubits/home_state.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import 'app_bar_state.dart';
import 'home_state.dart';

class AppBarCubit extends Cubit<AppBarState> {
  AppBarCubit()
      : super(
          AppBarInitial(),
        );

  void loadAppBar() {
    emit(AppBarLoading());
    emit(
      AppBarLoaded(
        appBar: AppBarModel.fromJson({'label': 'Chúc ngủ ngon!'}),
        type: HomeBodyType.home,
        label: txtDefault,
      ),
    );
  }

  void setAppBar(HomeBodyType type) async {
    if (state is AppBarLoaded) {
      emit((state as AppBarLoaded).copyWith(label: type.label, type: type));
    }
  }
}
