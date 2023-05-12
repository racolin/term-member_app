import 'dart:math';

import 'package:member_app/data/models/response_model.dart';

import '../../models/voucher_model.dart';
import '../../../business_logic/repositories/voucher_repository.dart';
import '../../../exception/app_message.dart';

class VoucherMockRepository extends VoucherRepository {
  @override
  Future<ResponseModel<List<VoucherModel>>> getsAvailable() async {
    return ResponseModel<List<VoucherModel>>(
      type: ResponseModelType.success,
      data: List.generate(
            4,
            (index) => VoucherModel(
              id: 'FREESHIP2023$index',
              code: 'VOUCHER$index',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              partner: 'The Coffee House',
              name: 'Giảm 50.000đ cho đơn 199.000đ',
              sliderImage:
                  'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
              from: DateTime(2023, 3, 29),
              to: DateTime(2023, 4, 29),
              usedAt: Random().nextBool() ? null : DateTime.now(),
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
            ),
          ) +
          List.generate(
            4,
            (index) => VoucherModel(
              id: 'FREESHIP2023$index',
              code: 'VOUCHER$index',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              partner: 'The Coffee House',
              name: 'Giảm 50.000đ cho đơn 199.000đ',
              sliderImage:
                  'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
              from: DateTime(2023, 3, 29),
              to: DateTime(2023, 4, 22),
              usedAt: Random().nextBool() ? null : DateTime.now(),
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
            ),
          ) +
          List.generate(
            2,
            (index) => VoucherModel(
              id: 'FREESHIP2023$index',
              code: 'VOUCHER$index',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              partner: 'PNJ',
              name: 'Giảm 50.000đ cho đơn 199.000đ',
              sliderImage:
                  'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
              from: DateTime(2023, 3, 29),
              to: DateTime(2023, 4, 22),
              usedAt: Random().nextBool() ? null : DateTime.now(),
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
            ),
          ),
    );
    return ResponseModel<List<VoucherModel>>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi lấy danh sách voucher có sẵn.',
      ),
    );
  }

  @override
  Future<ResponseModel<List<VoucherModel>>> getsUsed() async {
    return ResponseModel<List<VoucherModel>>(
      type: ResponseModelType.success,
      data: List.generate(
        4,
        (index) => VoucherModel(
          id: 'FREESHIP2023$index',
          code: 'VOUCHER$index',
          image:
              'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
          partner: 'The Coffee House',
          name: 'Giảm 50.000đ cho đơn 199.000đ',
          sliderImage:
              'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
          from: DateTime(2023, 3, 29),
          to: DateTime(2023, 4, 29),
          usedAt: Random().nextBool() ? null : DateTime.now(),
          description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
              '\n- Áp dụng cho toàn bộ menu The Coffee House'
              '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
        ),
      ),
    );
    return ResponseModel<List<VoucherModel>>(
      type: ResponseModelType.failure,
      message: AppMessage(
        type: AppMessageType.error,
        title: 'Lỗi mạng!',
        content: 'Gặp sự cố khi lấy danh sách voucher đã dùng.',
      ),
    );
  }
}
