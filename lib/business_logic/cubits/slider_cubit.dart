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
          'https://static.vecteezy.com/system/resources/thumbnails/001/073/526/small_2x/bubble-tea-cup-collection.jpg',
          'https://static.vecteezy.com/system/resources/thumbnails/001/073/526/small_2x/bubble-tea-cup-collection.jpg',
          'https://static.vecteezy.com/system/resources/previews/002/909/345/non_2x/bubble-milk-tea-special-promotions-design-boba-milk-tea-pearl-milk-tea-yummy-drinks-coffees-and-soft-drinks-with-logo-and-cute-funny-doodle-style-advertisement-banner-illustration-vector.jpg'
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
