import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/product_scroll_state.dart';


class ProductScrollCubit extends Cubit<ProductScrollState> {
  ProductScrollCubit() : super(ProductScrollInitial());

  void setIndex(int index) {
    emit(ProductScrollLoaded(index: index));
  }
}