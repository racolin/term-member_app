import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/repositories/news_api_repository.dart';
import 'package:member_app/exception/app_exception.dart';
import 'package:member_app/exception/app_message.dart';

import '../../business_logic/states/home_state.dart';
import '../../business_logic/cubits/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final _repository = NewsApiRepository();

  NewsCubit() : super(NewsInitial()) {
    emit(NewsLoading());
    try {
      _repository.gets().then((listNews) {
        emit(NewsLoaded(listNews: listNews, index: 0));
      });
    } on AppException catch(ex) {
      emit(NewsFailure(message: ex.message));
    }
  }

  // Action data
  Future<AppMessage?> reloadNews() async {
    try {
      var listNews = await _repository.gets();
      emit(NewsLoaded(listNews: listNews, index: 0));
    } on AppException catch(ex) {
      return ex.message;
    }
    return null;
  }

  // Action UI
  void setIndex(int index) {
    if (state is NewsLoaded) {
      emit((state as NewsLoaded).copyWith(index: index));
    }
  }
}
