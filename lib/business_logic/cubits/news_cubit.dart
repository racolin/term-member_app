import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/exception/app_message.dart';

import '../../business_logic/states/home_state.dart';
import '../../business_logic/cubits/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit()
      : super(
          NewsInitial(),
        );

  // Action data
  Future<AppMessage?> fetchNews() async {
    emit(NewsLoading());
  }

  void setIndex(int index) {
    if (state is NewsLoaded) {
      emit((state as NewsLoaded).copyWith(index: index));
    }
  }

  void setNews(HomeBodyType type) async {}
}
