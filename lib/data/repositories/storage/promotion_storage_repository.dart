import 'dart:math';

import 'package:dio/dio.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../../data/models/promotion_category_model.dart';
import '../../../data/models/promotion_model.dart';
import '../../../business_logic/repositories/promotion_repository.dart';
import '../../../exception/app_exception.dart';
import '../../../exception/app_message.dart';

class PromotionStorageRepository extends PromotionRepository {
  @override
  Future<ResponseModel<List<PromotionCategoryModel>>> getCategories() async {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<MapEntry<int, List<PromotionModel>>>> gets() async {
    throw UnimplementedError();
  }
}
