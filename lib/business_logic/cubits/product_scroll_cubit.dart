import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/product_scroll_state.dart';


class ProductScrollCubit extends Cubit<ProductScrollState> {
  ProductScrollCubit() : super(ProductScrollInitial());

  void setIndex(int index) {
    emit(ProductScrollLoaded(index: index));
  }

// base method: return response model, use to avoid repeat code.

// api method

// get data method: return model if state is loaded, else return null
}