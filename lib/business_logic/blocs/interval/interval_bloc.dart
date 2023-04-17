import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'interval_submit.dart';

part 'interval_event.dart';
part 'interval_state.dart';

class IntervalBloc<T> extends Bloc<IntervalEvent, IntervalState<T>> {
  final IntervalSubmit<T> _submit;

  IntervalBloc({required IntervalSubmit<T> submit})
      : _submit = submit,
        super(IntervalLoaded(list: const [], reload: true)) {
    on<IntervalSearch>((event, emit) async {
      if (state is IntervalLoaded<T>) {
        var state = this.state as IntervalLoaded<T>;
        emit(state.copyWith(reload: true));
        emit(
          state.copyWith(
            reload: false,
            list: await _submit.submit(event.key),
          ),
        );
      }
    }, transformer: debounce(duration: const Duration(seconds: 1)));
    on<IntervalLoad>((event, emit) async {
      emit(IntervalLoading());
      emit(IntervalLoaded(list: await _submit.submit(), reload: false,));
    });
  }

  EventTransformer<IntervalEvent> debounceRestartable<IntervalEvent>(
    Duration duration,
  ) {
    // This feeds the debounced event stream to restartable() and returns that
    // as a transformer.
    return (events, mapper) => events.debounceTime(duration);
  }

  EventTransformer<IntervalEvent> debounce<IntervalEvent>({
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return (events, mapper) => events
        .debounce(
          (event) => TimerStream(true, duration),
        )
        .switchMap(mapper);
  }
}
