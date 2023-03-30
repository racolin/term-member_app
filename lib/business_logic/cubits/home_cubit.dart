import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/app_bar_state.dart';

class HomeCubit extends Cubit<AppBarState> {
  HomeCubit()
      : super(
          Home(
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
