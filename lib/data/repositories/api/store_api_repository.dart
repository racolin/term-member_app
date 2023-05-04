import 'package:dio/dio.dart';
import 'package:member_app/data/models/store_detail_model.dart';

import '../../../data/models/store_model.dart';
import '../../../business_logic/repositories/store_repository.dart';
import '../../../exception/app_exception.dart';
import '../../../exception/app_message.dart';

class StoreStorageRepository extends StoreRepository {
  var _list = List.generate(
    10,
    (index) => StoreModel(
      id: 'STORE$index',
      address: 'Võ Thị Sáu, Quận 3, Thành phố Hồ Chí Minh',
      name: '175A Lý Chính Thắng',
      image: 'https://file.hstatic.net/1000075078/file/grandview5_35ccc48004574095b53e1de3b86a9eb5_master.jpg',
      distance: 100 * index * index,
      isFavorite: false,
    ),
  );

  @override
  Future<bool?> changeFavorite({required String id}) async {
    try {
      return true;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi thay đổi cửa hàng yêu thích!',
        ),
      );
    }
    return false;
  }

  @override
  Future<StoreDetailModel?> getDetail({required String id}) async {
    try {
      return StoreDetailModel(
        id: id,
        openTime: '07:00-21:00',
        phone: '0868754872',
        images: [
          'https://file.hstatic.net/1000075078/file/sig-04_45f046ffbfa94c069b4d9697e8444baa_master.png',
          'https://file.hstatic.net/1000075078/file/sig-01_2c5b08d6b9294c82ac64901e12ae6106_master.png',
          'https://file.hstatic.net/1000075078/file/grandview3_badde8d8296d4474b7ecb2ae67fb2dd8_master.jpg',
          'https://file.hstatic.net/1000075078/file/grandview5_35ccc48004574095b53e1de3b86a9eb5_master.jpg',
        ],
        unavailableProducts: ['PRODUCT-1','PRODUCT-12','PRODUCT-4',],
        unavailableOptions: ['OPTION-1',],
        unavailableCategories: [],
      );
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy danh sách cửa hàng',
        ),
      );
    }
  }

  @override
  Future<List<StoreModel>> gets() async {
    try {
      return _list;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy danh sách cửa hàng',
        ),
      );
    }
    return [];
  }
}
