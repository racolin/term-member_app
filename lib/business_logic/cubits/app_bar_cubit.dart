import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/app_bar_state.dart';

class AppBarCubit extends Cubit<AppBarState> {
  AppBarCubit()
      : super(
          AppBarState(
            homeBodyType: HomeBodyType.home,
          ),
        );

  void setBody(HomeBodyType type) => emit(state.copyWith(homeBodyType: type));

  void setExpand(bool isExpandFloating) => emit(state.copyWith(
        isExpandFloating: isExpandFloating,
      ));

  void setShowExpand(bool isShowFloatButton) => emit(state.copyWith(
        isShowFloatButton: isShowFloatButton,
      ));
}
