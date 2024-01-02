import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/response_model.dart';
import '../../exception/app_message.dart';
import '../repositories/slider_repository.dart';
import '../states/slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  final SliderRepository _repository;

  SliderCubit({required SliderRepository repository})
      : _repository = repository,
        super(SliderInitial()) {
    emit(SliderLoading());
    // print'object12121');
    _repository.gets().then((res) {
      if (res.type == ResponseModelType.success) {
        emit(SliderLoaded(list: res.data, index: 0));
      } else {
        emit(SliderFailure(message: res.message));
      }
    });
  }

  // base method: return response model, use to avoid repeat code.

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  // Action data
  Future<AppMessage?> reloadSlider() async {
      var res = await _repository.gets();
      if (res.type == ResponseModelType.success) {
        emit(SliderLoaded(list: res.data, index: 0));
        return null;
      } else {
        return res.message;
      }
  }

  // Action UI
  void setIndex(int index) {
    if (state is SliderLoaded) {
      emit((state as SliderLoaded).copyWith(index: index));
    }
  }
}
