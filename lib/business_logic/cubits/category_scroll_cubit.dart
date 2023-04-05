import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_scroll_state.dart';

class CategoryScrollCubit extends Cubit<CategoryScrollState> {
  CategoryScrollCubit() : super(CategoryScrollInitial());

  void setIndex(int index) {
    emit(CategoryScrollIndex(index: index));
  }
}
