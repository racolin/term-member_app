import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/home_state.dart';
import 'package:member_app/business_logic/cubits/promotion_state.dart';
import 'package:member_app/data/models/promotion_category_model.dart';

import '../../data/models/promotion_model.dart';
import 'promotion_state.dart';

class PromotionCubit extends Cubit<PromotionState> {
  PromotionCubit()
      : super(
          PromotionInitial(),
        );

  void loadPromotion() {
    emit(PromotionLoading());
    emit(
      PromotionLoaded(
        promotions: [
          ...List.generate(
            8,
            (index) => PromotionModel(
              id: 'PM-00',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              partner: 'Beauty Garden',
              title: 'Giảm 50.000đ cho đơn 199.000đ',
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
              expire: DateTime(2023, 3, 29),
              userFor: 86400 * 30,
              score: 99,
              categoryId: index,
              from: 0,
              rate: index * 10,
            ),
          ),
          ...List.generate(
            8,
            (index) => PromotionModel(
              id: 'PM-00',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              partner: 'Beauty Garden',
              title: 'Giảm 50.000đ cho đơn 199.000đ',
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
              expire: DateTime(2023, 3, 29),
              userFor: 86400 * 30,
              score: 99,
              categoryId: index,
              from: 1,
              rate: index * 15,
            ),
          ),
          ...List.generate(
            8,
            (index) => PromotionModel(
              id: 'PM-00',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              partner: 'Beauty Garden',
              title: 'Giảm 50.000đ cho đơn 199.000đ',
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
              expire: DateTime(2023, 3, 29),
              userFor: 86400 * 30,
              score: 99,
              categoryId: index,
              from: 0,
              rate: index * 15,
            ),
          ),
          ...List.generate(
            8,
            (index) => PromotionModel(
              id: 'PM-00',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              partner: 'Beauty Garden',
              title: 'Giảm 50.000đ cho đơn 199.000đ',
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
              expire: DateTime(2023, 3, 29),
              userFor: 86400 * 30,
              score: 99,
              categoryId: index,
              from: 1,
              rate: index * 30,
            ),
          ),
          ...List.generate(
            8,
            (index) => PromotionModel(
              id: 'PM-00',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              partner: 'Beauty Garden',
              title: 'Giảm 50.000đ cho đơn 199.000đ',
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
              expire: DateTime(2023, 3, 29),
              userFor: 86400 * 30,
              score: 99,
              categoryId: index,
              from: 0,
              rate: index * 5,
            ),
          ),
          ...List.generate(
            8,
            (index) => PromotionModel(
              id: 'PM-00',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              partner: 'Beauty Garden',
              title: 'Giảm 50.000đ cho đơn 199.000đ',
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
              expire: DateTime(2023, 3, 29),
              userFor: 86400 * 30,
              score: 99,
              categoryId: index,
              from: 1,
              rate: index * 8,
            ),
          ),
          ...List.generate(
            8,
            (index) => PromotionModel(
              id: 'PM-00',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              partner: 'Beauty Garden',
              title: 'Giảm 50.000đ cho đơn 199.000đ',
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
              expire: DateTime(2023, 3, 29),
              userFor: 86400 * 30,
              score: 99,
              categoryId: index,
              from: 0,
              rate: index * 20,
            ),
          ),
          ...List.generate(
            8,
            (index) => PromotionModel(
              id: 'PM-00',
              image:
                  'https://www.tiendauroi.com/wp-content/uploads/2019/05/2409aa3f79aad8d71acdf0bf233353bbded1a009.jpeg',
              partner: 'Beauty Garden',
              title: 'Giảm 50.000đ cho đơn 199.000đ',
              description: 'Miễn phí giao hàng cho đơn hàng bất kì: '
                  '\n- Áp dụng cho toàn bộ menu The Coffee House'
                  '\n- Không áp dụng cho các chường trình khuyến mãi song song.',
              expire: DateTime(2023, 3, 29),
              userFor: 86400 * 30,
              score: 99,
              categoryId: index,
              from: 1,
              rate: index * 11,
            ),
          ),
        ],
        categories: [
          PromotionCategoryModel(
            id: 0,
            title: 'Tất cả',
            image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
          ),
          PromotionCategoryModel(
            id: 1,
            title: 'The Coffee House',
            image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
          ),
          PromotionCategoryModel(
            id: 2,
            title: 'Ăn uống',
            image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
          ),
          PromotionCategoryModel(
            id: 3,
            title: 'Du lịch',
            image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
          ),
          PromotionCategoryModel(
            id: 4,
            title: 'Mua sắm',
            image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
          ),
          PromotionCategoryModel(
            id: 5,
            title: 'Giải trí',
            image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
          ),
          PromotionCategoryModel(
            id: 6,
            title: 'Dịch vụ',
            image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
          ),
          PromotionCategoryModel(
            id: 7,
            title: 'Giới hạn',
            image: 'https://api.assistivecards.com/cards/drinks/iced-tea.png',
          ),
        ],
      ),
    );
  }

  void setIndex(int index) {
    if (state is PromotionLoaded) {
      emit((state as PromotionLoaded).copyWith());
    }
  }

  void setPromotion(HomeBodyType type) async {}
}
