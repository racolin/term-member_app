import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/store_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HomeState(
            homeBodyType: HomeBodyType.home,
            deliveryType: DeliveryType.takeOut,
            deliveryDescription: '175B Cao Thắng',
          ),
        );

  void setBody(HomeBodyType type) => emit(state.copyWith(homeBodyType: type));

  void setExpand(bool isExpandFloating) => emit(state.copyWith(
        isExpandFloating: isExpandFloating,
      ));

  void setShowExpand(bool isShowFloatButton) => emit(state.copyWith(
        isShowFloatButton: isShowFloatButton,
      ));

  void setStore(StoreShortModel store) {
    emit(state.copyWith(
      deliveryType: DeliveryType.takeOut,
      deliveryDescription: store.name,
    ));
  }
}
