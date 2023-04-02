import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/slider_state.dart';
import 'package:member_app/data/models/slider_model.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial());

  void loadSlider() {
    emit(SliderLoading());
    emit(
      SliderLoaded(
        sliders: [
          'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
          'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
          'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
          'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
          'https://static.vecteezy.com/system/resources/thumbnails/001/073/526/small_2x/bubble-tea-cup-collection.jpg',
          'https://static.vecteezy.com/system/resources/thumbnails/001/073/526/small_2x/bubble-tea-cup-collection.jpg',
        ]
            .map((e) => SliderModel(
                  image: e,
                  voucherID: 'VOUCHER',
                ))
            .toList(),
      ),
    );
  }
}
