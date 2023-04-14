import 'package:dio/dio.dart';

import '../../business_logic/repositories/news_repository.dart';
import '../../data/models/news_model.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';

class NewsApiRepository extends NewsRepository {
  @override
  Future<List<NewsModel>> gets() async {
    try {
      return [
        NewsModel(
          id: 'NEWS1',
          name: 'Ưu đãi đặc biệt',
          items: List.generate(
            7,
            (index) => NewsItemModel(
              id: 'NEWSITEM',
              name: 'Cà phê đường đen: Vượt chuẩn vị men',
              image:
                  'https://scontent.fsgn5-8.fna.fbcdn.net/v/t39.30808-6/277569606_3220892998184704_7534103870995634759_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=730e14&_nc_ohc=viDyVLFA7pUAX83Gf1J&_nc_ht=scontent.fsgn5-8.fna&oh=00_AfCONh9FbP0sxdwC8q1o5COI47GdopEyvouMfqRlNLoZrg&oe=643D1A66',
              time: DateTime.now(),
              url: 'https://flutter.dev/',
            ),
          ),
        ),
        NewsModel(
          id: 'NEWS2',
          name: 'Cập nhật từ nhà',
          items: List.generate(
            7,
            (index) => NewsItemModel(
              id: 'NEWSITEM',
              name: 'Cà phê đường đen: Vượt chuẩn vị men',
              image:
                  'https://scontent.fsgn5-8.fna.fbcdn.net/v/t39.30808-6/277569606_3220892998184704_7534103870995634759_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=730e14&_nc_ohc=viDyVLFA7pUAX83Gf1J&_nc_ht=scontent.fsgn5-8.fna&oh=00_AfCONh9FbP0sxdwC8q1o5COI47GdopEyvouMfqRlNLoZrg&oe=643D1A66',
              time: DateTime.now(),
              url: 'https://flutter.dev/',
            ),
          ),
        ),
        NewsModel(
          id: 'NEWS3',
          name: '#CoffeeLover',
          items: List.generate(
            7,
            (index) => NewsItemModel(
              id: 'NEWSITEM',
              name: 'Cà phê đường đen: Vượt chuẩn vị men',
              image:
                  'https://scontent.fsgn5-8.fna.fbcdn.net/v/t39.30808-6/277569606_3220892998184704_7534103870995634759_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=730e14&_nc_ohc=viDyVLFA7pUAX83Gf1J&_nc_ht=scontent.fsgn5-8.fna&oh=00_AfCONh9FbP0sxdwC8q1o5COI47GdopEyvouMfqRlNLoZrg&oe=643D1A66',
              time: DateTime.now(),
              url: 'https://flutter.dev/',
            ),
          ),
        ),
      ];
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy App Bar',
        ),
      );
    }
    return [];
  }
}
