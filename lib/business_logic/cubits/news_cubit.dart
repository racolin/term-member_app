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
    _repository.gets().then((res) {
      if (res.type == AppMessageType.success) {
        emit(NewsLoaded(list: res.data, index: 0));
      } else {
        emit(NewsFailure(message: res.message));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  // Action data
  Future<AppMessage?> reloadNews() async {
      var res = await _repository.gets();
      if (res.type == AppMessageType.success) {
        emit(NewsLoaded(list: res.data, index: 0));
        return null;
      } else {
        return res.message;
      }
  }

  // Action UI
  void setIndex(int index) {
    if (state is NewsLoaded) {
      emit((state as NewsLoaded).copyWith(index: index));
    }
  }
}
