import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/store_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void loadCart({String? storeID}) {
    emit(CartLoading());
    emit(CartLoaded());
  }

  void setStore(StoreShortModel store) {
    if (state is CartLoaded) {
      emit(
        (state as CartLoaded).copyWith(
          store: store,
        ),
      );
    }
  }
}
