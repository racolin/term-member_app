import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/mock/news_mock_repository.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';
import '../repositories/news_repository.dart';
import '../states/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _repository;

  NewsCubit({required NewsRepository repository})
      : _repository = repository,
        super(NewsInitial()) {
    emit(NewsLoading());
    try {
      _repository.gets().then((list) {
        emit(NewsLoaded(list: list, index: 0));
      });
    } on AppException catch (ex) {
      emit(NewsFailure(message: ex.message));
    }
  }

  // base method: return response model, use to avoid repeat code.

  // api method

  // get data method: return model if state is loaded, else return null

  // Action data
  Future<AppMessage?> reloadNews() async {
    try {
      var list = await _repository.gets();
      emit(NewsLoaded(list: list, index: 0));
    } on AppException catch (ex) {
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
