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
      String label = '';
      switch (type) {
        case HomeBodyType.order:
          label = txtOrder;
          break;
        case HomeBodyType.home:
          label = txtHome;
          break;
        case HomeBodyType.store:
          label = txtStore;
          break;
        case HomeBodyType.promotion:
          label = txtPromotion;
          break;
        case HomeBodyType.other:
          label = txtOther;
          break;
      }
      emit((state as AppBarLoaded).copyWith(label: label, type: type));
    }
  }
}
