import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/test_state.dart';


class StCubit extends Cubit<TestState> {
  StCubit() : super(StInitial());
}
