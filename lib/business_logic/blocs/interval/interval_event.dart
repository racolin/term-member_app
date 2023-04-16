part of 'interval_bloc.dart';

@immutable
abstract class IntervalEvent {}

class IntervalLoad extends IntervalEvent {}

class IntervalSearch extends IntervalEvent {
  final String key;
  IntervalSearch({required this.key});
}
