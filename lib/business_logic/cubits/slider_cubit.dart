import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderLoading());
}
