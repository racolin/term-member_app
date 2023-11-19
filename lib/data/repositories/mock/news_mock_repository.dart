import 'package:member_app/data/models/response_model.dart';

import '../../../business_logic/repositories/news_repository.dart';
import '../../models/news_model.dart';
import '../../../exception/app_message.dart';

class NewsMockRepository extends NewsRepository {
  @override
  Future<ResponseModel<List<NewsModel>>> gets() async {
    return ResponseModel<List<NewsModel>>(
        type: ResponseModelType.success,
        data: [
          NewsModel(
            id: 'NEWS1',
            name: 'Ưu đãi đặc biệt',
            news: List.generate(
              7,
              (index) => NewsItemModel(
                id: 'NEWSITEM',
                name: 'Cà phê đường đen: Vượt chuẩn vị men',
                image:
                    'https://product.hstatic.net/1000075078/product/1669707374_1642353251-ca-phe-dam-vi-viet-tui-new_7fdd610e98f54bcbb9b74992c14d1aed_master.jpg',
                time: DateTime.now(),
                url: 'https://flutter.dev/',
              ),
            ),
          ),
          NewsModel(
            id: 'NEWS2',
            name: 'Cập nhật từ nhà',
            news: List.generate(
              7,
              (index) => NewsItemModel(
                id: 'NEWSITEM',
                name: 'Cà phê đường đen: Vượt chuẩn vị men',
                image:
                    'https://product.hstatic.net/1000075078/product/1669707374_1642353251-ca-phe-dam-vi-viet-tui-new_7fdd610e98f54bcbb9b74992c14d1aed_master.jpg',
                time: DateTime.now(),
                url: 'https://flutter.dev/',
              ),
            ),
          ),
          NewsModel(
            id: 'NEWS3',
            name: '#CoffeeLover',
            news: List.generate(
              7,
              (index) => NewsItemModel(
                id: 'NEWSITEM',
                name: 'Cà phê đường đen: Vượt chuẩn vị men',
                image:
                    'https://product.hstatic.net/1000075078/product/1669707374_1642353251-ca-phe-dam-vi-viet-tui-new_7fdd610e98f54bcbb9b74992c14d1aed_master.jpg',
                time: DateTime.now(),
                url: 'https://flutter.dev/',
              ),
            ),
          ),
        ]);
    return ResponseModel<List<NewsModel>>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi lấy App Bar',
      ),
    );
  }
}
