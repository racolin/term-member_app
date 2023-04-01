import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/home_state.dart';
import 'package:member_app/business_logic/cubits/news_state.dart';
import 'package:member_app/data/models/news_model.dart';
import 'package:member_app/data/models/product_model.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../supports/convert.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit()
      : super(
          NewsInitial(),
        );

  void loadNews() {
    emit(NewsLoading());
    emit(
      NewsLoaded(
        listNews: [
          NewsModel(
            title: 'Ưu đãi đặc biệt',
            newsItems: [
              NewsItemModel(
                title: 'nhóm đông vui - khui quà nhà',
                image:
                    'https://img.freepik.com/free-vector/brown-sugar-bubble-milk-tea-set-promotion-free-flyer-template-watercolor-illustration_83728-563.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
              NewsItemModel(
                title: 'deal ngon tuyệt vời - nhà mời chốt đơn',
                image:
                    'https://www.everydayonsales.com/wp-content/uploads/2020/04/Black-Whale-Milk-Tea-Extra-15-Off-Promo.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
              NewsItemModel(
                title: 'Hi-tea healthy: 0đ chờ chi',
                image:
                    'https://cupcommunity.com/wp-content/uploads/2021/02/Cheesecake-and-Pearl-Milk-Tea-for-only-2-pesos-1.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
              NewsItemModel(
                title: 'Ngày deal nhẹ như mây - Săn deal 0đ ngay',
                image:
                    'https://www.crushpixel.com/static13/preview2/stock-photo-matcha-and-brown-sugar-bubble-milk-tea-set-promotion-ad-template-watercolor-illustration-design-1124701.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
              NewsItemModel(
                title: 'Tiên cày task - hậu mời deal chỉ từ 39k',
                image:
                    'https://sg.everydayonsales.com/wp-content/uploads/2022/01/Tuk-Tuk-Cha-1-for-1-Thai-Milk-Tea-Promo.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
            ],
          ),
          NewsModel(
            title: 'Cập nhật từ nhà',
            newsItems: [
              NewsItemModel(
                title: 'Hi-tea healthy: 0đ chờ chi',
                image:
                    'https://cupcommunity.com/wp-content/uploads/2021/02/Cheesecake-and-Pearl-Milk-Tea-for-only-2-pesos-1.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
              NewsItemModel(
                title: 'Ngày deal nhẹ như mây - Săn deal 0đ ngay',
                image:
                    'https://www.crushpixel.com/static13/preview2/stock-photo-matcha-and-brown-sugar-bubble-milk-tea-set-promotion-ad-template-watercolor-illustration-design-1124701.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
              NewsItemModel(
                title: 'nhóm đông vui - khui quà nhà',
                image:
                    'https://img.freepik.com/free-vector/brown-sugar-bubble-milk-tea-set-promotion-free-flyer-template-watercolor-illustration_83728-563.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
              NewsItemModel(
                title: 'deal ngon tuyệt vời - nhà mời chốt đơn',
                image:
                    'https://www.everydayonsales.com/wp-content/uploads/2020/04/Black-Whale-Milk-Tea-Extra-15-Off-Promo.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
              NewsItemModel(
                title: 'Tiên cày task - hậu mời deal chỉ từ 39k',
                image:
                    'https://sg.everydayonsales.com/wp-content/uploads/2022/01/Tuk-Tuk-Cha-1-for-1-Thai-Milk-Tea-Promo.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
            ],
          ),
          NewsModel(
            title: 'CoffeeLover',
            newsItems: [
              NewsItemModel(
                title: 'Ngày deal nhẹ như mây - Săn deal 0đ ngay',
                image:
                    'https://www.crushpixel.com/static13/preview2/stock-photo-matcha-and-brown-sugar-bubble-milk-tea-set-promotion-ad-template-watercolor-illustration-design-1124701.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
              NewsItemModel(
                title: 'Tiên cày task - hậu mời deal chỉ từ 39k',
                image:
                    'https://sg.everydayonsales.com/wp-content/uploads/2022/01/Tuk-Tuk-Cha-1-for-1-Thai-Milk-Tea-Promo.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
              NewsItemModel(
                title: 'nhóm đông vui - khui quà nhà',
                image:
                    'https://img.freepik.com/free-vector/brown-sugar-bubble-milk-tea-set-promotion-free-flyer-template-watercolor-illustration_83728-563.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
              NewsItemModel(
                title: 'deal ngon tuyệt vời - nhà mời chốt đơn',
                image:
                    'https://www.everydayonsales.com/wp-content/uploads/2020/04/Black-Whale-Milk-Tea-Extra-15-Off-Promo.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
              NewsItemModel(
                title: 'Hi-tea healthy: 0đ chờ chi',
                image:
                    'https://cupcommunity.com/wp-content/uploads/2021/02/Cheesecake-and-Pearl-Milk-Tea-for-only-2-pesos-1.jpg',
                link: '',
                dateTime: dateToString(DateTime.now(), 'dd/MM'),
              ),
            ],
          ),
        ],
        index: 0,
      ),
    );
  }

  void setIndex(int index) {
    if (state is NewsLoaded) {
      emit((state as NewsLoaded).copyWith(index: index));
    }
  }

  void setNews(HomeBodyType type) async {}
}
