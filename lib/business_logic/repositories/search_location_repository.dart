import '../../data/models/response_model.dart';

abstract class SearchLocationRepository {

  ///
  /// Success: data = true, message = null (data always true)
  ///
  /// Failure: data = null, message != null
  ///
  Future<ResponseModel<void>> search();
}
