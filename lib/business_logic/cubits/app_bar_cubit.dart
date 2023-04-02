import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/app_bar_model.dart';
import 'package:member_app/business_logic/cubits/app_bar_state.dart';
import 'package:member_app/business_logic/cubits/home_state.dart';
import 'package:member_app/presentation/res/strings/values.dart';

class AppBarCubit extends Cubit<AppBarState> {
  AppBarCubit()
      : super(
          AppBarInitial(),
        );

  void loadAppBar() {
    emit(AppBarLoading());
    emit(
      AppBarLoaded(
        appBar: AppBarModel.fromMap({'label': 'Chúc ngủ ngon!'}),
        type: HomeBodyType.home,
        label: txtUnknown,
      ),
    );
  }

  void setAppBar(HomeBodyType type) async {
    if (state is AppBarLoaded) {
      emit((state as AppBarLoaded).copyWith(label: type.label, type: type));
    }
  }
}
