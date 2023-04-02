part of 'store_bloc.dart';

@immutable
abstract class StoreEvent {}

class StoreLoad {}

class StoreSearch {
  final String key;
  StoreSearch({required this.key});
}
