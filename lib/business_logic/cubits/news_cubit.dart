import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/news_api_repository.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';
import '../states/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final _repository = NewsApiRepository();

  NewsCubit() : super(NewsInitial()) {
    emit(NewsLoading());
    try {
      _repository.gets().then((list) {
        emit(NewsLoaded(list: list, index: 0));
      });
    } on AppException catch(ex) {
      emit(NewsFailure(message: ex.message));
    }
  }

  // Action data
  Future<AppMessage?> reloadNews() async {
    try {
      var list = await _repository.gets();
      emit(NewsLoaded(list: list, index: 0));
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
