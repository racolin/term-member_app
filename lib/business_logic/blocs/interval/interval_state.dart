part of 'interval_bloc.dart';


@immutable
abstract class IntervalState<T> {}

class IntervalInitial<T> extends IntervalState<T> {}

class IntervalLoading<T> extends IntervalState<T> {}

class IntervalLoaded<T> extends IntervalState<T> {
  final List<T> list;
  final bool reload;

  IntervalLoaded({
    required this.list,
    this.reload = false,
  });

  IntervalLoaded<T> copyWith({
    List<T>? list,
    bool? reload,
  }) {
    return IntervalLoaded<T>(
      list: list ?? this.list,
      reload: reload ?? this.reload,
    );
  }
}
