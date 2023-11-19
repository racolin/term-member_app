import 'package:member_app/data/models/slider_model.dart';

import '../../data/models/response_model.dart';

abstract class SliderRepository {
  Future<ResponseModel<List<SliderModel>>> gets();
}
