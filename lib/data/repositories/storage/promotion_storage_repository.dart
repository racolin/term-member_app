import 'dart:math';

import 'package:dio/dio.dart';

import '../../../data/models/promotion_category_model.dart';
import '../../../data/models/promotion_model.dart';
import '../../../business_logic/repositories/promotion_repository.dart';
import '../../../exception/app_exception.dart';
import '../../../exception/app_message.dart';

class PromotionApiRepository extends PromotionRepository {
  @override
  Future<List<PromotionCategoryModel>> getCategories() async {
    try {
      return [
        PromotionCategoryModel(
          id: 0,
          name: 'Tất cả',
          image: 'https://apprecs.org/gp/images/app-icons/300/d1/com.thecoffeehouse.guestapp.jpg',
          promotionIds: ["PM-1", "PM-5", "PM-8", "PM-12", "PM-13", ],
        ),
        PromotionCategoryModel(
          id: 1,
          name: 'The Coffee House',
          image: 'https://apprecs.org/gp/images/app-icons/300/d1/com.thecoffeehouse.guestapp.jpg',
          promotionIds: ["PM-3", "PM-2", "PM-8", "PM-15", "PM-10", ],
        ),
        PromotionCategoryModel(
          id: 2,
          name: 'Ăn uống',
          image: 'https://apprecs.org/gp/images/app-icons/300/d1/com.thecoffeehouse.guestapp.jpg',
          promotionIds: ["PM-1", "PM-5", "PM-8", "PM-12", "PM-13", ],
        ),
        PromotionCategoryModel(
          id: 3,
          name: 'Du lịch',
          image: 'https://apprecs.org/gp/images/app-icons/300/d1/com.thecoffeehouse.guestapp.jpg',
          promotionIds: ["PM-1", "PM-5", "PM-8", "PM-12", "PM-13", ],
        ),
        PromotionCategoryModel(
          id: 4,
          name: 'Mua sắm',
          image: 'https://apprecs.org/gp/images/app-icons/300/d1/com.thecoffeehouse.guestapp.jpg',
          promotionIds: ["PM-1", "PM-5", "PM-8", "PM-12", "PM-13", ],
        ),
        PromotionCategoryModel(
          id: 5,
          name: 'Giải trí',
          image: 'https://apprecs.org/gp/images/app-icons/300/d1/com.thecoffeehouse.guestapp.jpg',
          promotionIds: ["PM-1", "PM-5", "PM-8", "PM-12", "PM-13", ],
        ),
        PromotionCategoryModel(
          id: 6,
          name: 'Dịch vụ',
          image: 'https://apprecs.org/gp/images/app-icons/300/d1/com.thecoffeehouse.guestapp.jpg',
          promotionIds: ["PM-1", "PM-5", "PM-8", "PM-12", "PM-13", ],
        ),
        PromotionCategoryModel(
          id: 7,
          name: 'Giới hạn',
          image: 'https://apprecs.org/gp/images/app-icons/300/d1/com.thecoffeehouse.guestapp.jpg',
          promotionIds: ["PM-1", "PM-5", "PM-8", "PM-12", "PM-13", ],
        ),
      ];
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy danh sách loai promotion',
        ),
      );
    }
    return [];
  }

  @override
  Future<MapEntry<int, List<PromotionModel>>> gets() async {
    try {
      return MapEntry(800, List.generate(
        7,
            (index) => PromotionModel(
          id: 'PM-$index',
          partnerImage:
          'https://apprecs.org/gp/images/app-icons/300/d1/com.thecoffeehouse.guestapp.jpg',
          partner: 'Beauty Garden',
          name: 'Giảm 50.000đ cho đơn 199.000đ',
          description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
              '\n- Áp dụng cho toàn bộ menu The Coffee House'
              '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
          expire: 30,
          point: 99,
          from: DateTime(2023, 3, 17),
          to: DateTime(2023, 5, 17),
          mark: (Random().nextDouble() * 400).toInt() + 600,
          backgroundImage:
          'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
        ),
      ) + List.generate(
        7,
            (index) => PromotionModel(
          id: 'PM-$index',
          partnerImage:
          'https://apprecs.org/gp/images/app-icons/300/d1/com.thecoffeehouse.guestapp.jpg',
          partner: 'The Coffee House',
          name: 'Giảm 50.000đ cho đơn 199.000đ',
          description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
              '\n- Áp dụng cho toàn bộ menu The Coffee House'
              '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
          expire: 30,
          point: 99,
          from: DateTime(2023, 3, 17),
          to: DateTime(2023, 5, 17),
          mark: (Random().nextDouble() * 400).toInt() + 600,
          backgroundImage:
          'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
        ),
      ));
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          type: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy danh sách promotion',
        ),
      );
    }
    return MapEntry(0, []);
  }
}
