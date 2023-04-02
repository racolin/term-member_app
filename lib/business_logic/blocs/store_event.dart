part of 'store_bloc.dart';

@immutable
abstract class StoreEvent {}

class StoreLoad extends StoreEvent {}

class StoreSearch extends StoreEvent {
  final String key;
  StoreSearch({required this.key});
}
