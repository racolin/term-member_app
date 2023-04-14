import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/home_state.dart';
import 'package:member_app/business_logic/cubits/promotion_state.dart';
import 'package:member_app/business_logic/cubits/voucher_state.dart';
import 'package:member_app/data/models/promotion_category_model.dart';
import 'package:member_app/data/models/voucher_model.dart';

import '../../data/models/promotion_model.dart';
import '../../data/models/voucher_category_model.dart';
import 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  VoucherCubit()
      : super(
          VoucherInitial(),
        );

  void loadVoucher() {
    emit(VoucherLoading());
    emit(
      VoucherLoaded(
        vouchers: [
          ...List.generate(
            4,
            (index) => VoucherModel(
              id: 'FREESHIP2023$index',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              title: 'Giảm 50.000đ cho đơn 199.000đ',
              slider:
                  'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
              categoryId: index,
              partner: 'The Coffee House',
              from: DateTime(2023, 3, 29),
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
              expire: DateTime(2023, 4, 29),
            ),
          ),
          ...List.generate(
            4,
            (index) => VoucherModel(
              id: 'FREESHIP2023$index',
              image:
                  'https://stc.shopiness.vn/deal/2020/02/06/6/2/e/1/1580963857029_540.png',
              title: 'Giảm 20K đơn 50K',
              partner: 'Beauty Garden',
              slider:
                  'https://static.vecteezy.com/system/resources/thumbnails/001/073/526/small_2x/bubble-tea-cup-collection.jpg',
              categoryId: index,
              from: DateTime(2023, 3, 29),
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
              expire: DateTime(2023, 4, 29),
            ),
          ),
        ],
        categories: [
          VoucherCategoryModel(id: 0, title: 'Sắp hết hạn'),
          VoucherCategoryModel(id: 1, title: 'Sẵn sàng sử dụng'),
          VoucherCategoryModel(id: 2, title: 'Đã sử dụng'),
          VoucherCategoryModel(id: 3, title: 'Đã hết hạn ()'),
        ],
      ),
    );
  }

  void setIndex(int index) {
    if (state is VoucherLoaded) {
      emit((state as VoucherLoaded).copyWith());
    }
  }

  void setVoucher(HomeBodyType type) async {}
}
