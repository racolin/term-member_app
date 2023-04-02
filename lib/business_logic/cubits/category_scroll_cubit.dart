import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/category_product_state.dart';
import 'package:member_app/data/models/card_model.dart';
import 'package:member_app/data/models/category_model.dart';

import 'category_scroll_state.dart';

class CategoryScrollCubit extends Cubit<CategoryScrollState> {
  CategoryScrollCubit() : super(CategoryScrollInitial());

  void setIndex(int index) {
    emit(CategoryScrollIndex(index: index));
  }
}
