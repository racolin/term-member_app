import 'package:member_app/data/models/response_model.dart';

import '../../../business_logic/repositories/slider_repository.dart';
import '../../models/slider_model.dart';

class SliderStorageRepository extends SliderRepository {
  @override
  Future<ResponseModel<List<SliderModel>>> gets() async {
    throw UnimplementedError();
  }
}
