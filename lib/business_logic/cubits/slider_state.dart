import 'package:member_app/data/models/slider_model.dart';

abstract class SliderState {}

class SliderInitial extends SliderState {}

class SliderLoading extends SliderState {}

class SliderLoaded extends SliderState {
  final List<SliderModel> sliders;

  SliderLoaded({
    required this.sliders,
  });
}
