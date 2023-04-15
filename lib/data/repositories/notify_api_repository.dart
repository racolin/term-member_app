import 'package:dio/dio.dart';

import '../../data/models/notify_model.dart';
import '../../business_logic/repositories/notify_repository.dart';
import '../../exception/app_exception.dart';
import '../../exception/app_message.dart';

class NotifyApiRepository extends NotifyRepository {
  var _list = [
    ...List.generate(
      8,
      (index) => NotifyModel(
        id: 'NOTIFY-$index',
        name: 'Trải nghiệm đặt món hôm nay thế nào?',
        description: 'Mời bạn đánh giá đơn hàng vừa rồi để Nhà tiếp tục cải thiện. Xin cảm ơn bạn.',
        image: 'https://file.hstatic.net/1000075078/file/grandview3_badde8d8296d4474b7ecb2ae67fb2dd8_master.jpg',
        time: DateTime.now(),
        checked: false,
      ),
    ),
    ...List.generate(
      6,
      (index) => NotifyModel(
        id: 'NOTIFY-${index + 8}',
        name: 'Đổi thành công Voucher',
        description: 'Đặt hàng ngay bạn ơi, bạn đã đổi thành công voucher từ Nhà. Hãy vào xem ngay nào!',
        image: 'https://scontent.fsgn5-8.fna.fbcdn.net/v/t39.30808-6/277569606_3220892998184704_7534103870995634759_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=730e14&_nc_ohc=viDyVLFA7pUAX83Gf1J&_nc_ht=scontent.fsgn5-8.fna&oh=00_AfCONh9FbP0sxdwC8q1o5COI47GdopEyvouMfqRlNLoZrg&oe=643D1A66',
        time: DateTime.now(),
        checked: true,
      ),
    ),
  ];

  @override
  Future<bool?> checkNotify({required String id}) async {
    try {
      int index = _list.indexWhere((e) => e.id == id && e.checked == false);
      if (index > -1) {
        _list[index] = _list[index].copyWith(checked: true);
      }
      return true;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi xác nhận đã đọc thông báo',
        ),
      );
    }
    return false;
  }

  @override
  Future<List<NotifyModel>> gets() async {
    try {
      return _list;
    } on DioError catch (ex) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Lỗi mạng!',
          content: 'Gặp sự cố khi lấy dan sách thông báo',
        ),
      );
    }
    return [];
  }
}
