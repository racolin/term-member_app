import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/models/store_model.dart';

part 'store_event.dart';

part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitial()) {
    on<StoreSearch>((event, emit) async {
      if (state is StoreLoaded) {
        emit((state as StoreLoaded).copyWith(isReload: true));
        emit(
          (state as StoreLoaded).copyWith(
            isReload: false,
            searchStores: (state as StoreLoaded)
                .stores
                .where(
                  (e) =>
                      e.name.toLowerCase().contains(event.key.toLowerCase()) ||
                      e.fullAddress.toLowerCase().contains(event.key.toLowerCase()),
                )
                .toList(),
          ),
        );
      }
    }, transformer: debounce(duration: const Duration(seconds: 1)));
    on<StoreLoad>((event, emit) {
      emit(StoreLoading());
      emit(
        StoreLoaded(
          stores: const [
            StoreShortModel(
              id: 'ST-01',
              image:
                  'https://file.hstatic.net/1000075078/file/12247889_1646846445589375_3408761776751282080_o_5e0b353f0e7846699c422e487b5a5a2b.jpeg',
              fullAddress: '17 Út tịch, Phường 4, Tân Bình, Hồ Chí Minh',
              name: 'HCM Hoàng Việt',
              distance: 'Cách đây 1 km',
            ),
            StoreShortModel(
              id: 'ST-02',
              image:
                  'https://file.hstatic.net/1000075078/file/hcm-nguyen-xi2_78d0227d13774e1388d8c9e9e8e54f63.jpg',
              fullAddress:
                  '184 Nguyễn Xí, Phường 26, Bình Thạnh, Thành phố Hồ Chí Minh',
              name: 'HCM Nguyễn Xí',
              distance: 'Cách đây 2 km',
            ),
            StoreShortModel(
              id: 'ST-03',
              image:
                  'https://file.hstatic.net/1000075078/file/hcm-ap-bac3_79c18861770147dfb36e31e5752f3dc0.jpg',
              fullAddress: '4 - 6 Ấp Bắc, Q. Tân Bình, Hồ Chí Minh',
              name: 'HCM Ấp Bắc',
              distance: 'Cách đây 5 km',
            ),
            StoreShortModel(
              id: 'ST-04',
              image:
                  'https://file.hstatic.net/1000075078/file/hcm-binh-phu7_f2a8c0a193bf4aab9f7fce144b114eb1.jpg',
              fullAddress: '111-113-115 Bình Phú, Quận 6, Hồ Chí Minh',
              name: 'HCM Bình Phú',
              distance: 'Cách đây 1 km',
            ),
            StoreShortModel(
              id: 'ST-05',
              image:
                  'https://file.hstatic.net/1000075078/file/hcm_tinh_lo_10_1_0426474b62eb4fa98785c0161ab3a08e.jpg',
              fullAddress:
                  '516 Tỉnh Lộ 10, Bình Trị Đông, Bình Tân, Hồ Chí Minh',
              name: 'HCM Tỉnh Lộ 10',
              distance: 'Cách đây 4 km',
            ),
            StoreShortModel(
              id: 'ST-06',
              image:
                  'https://file.hstatic.net/1000075078/file/_kh_9431__1__e19a7a49963245b39b280271da3cd9fb.jpg',
              fullAddress:
                  '71 Hoàng Văn Thái, Tân Phú, Quận 7, Thành phố Hồ Chí Minh',
              name: 'HCM The Grace Tower',
              distance: 'Cách đây 3 km',
            ),
            StoreShortModel(
              id: 'ST-07',
              image:
                  'https://file.hstatic.net/1000075078/file/grandview5_35ccc48004574095b53e1de3b86a9eb5.jpg',
              fullAddress:
                  '159 Nguyễn Đức Cảnh, Khu Grand View, Tân Phong, Quận 7, Thành phố Hồ Chí Minh',
              name: 'HCM The Grand View',
              distance: 'Cách đây 1 km',
            ),
          ],
        ),
      );
    });
  }

  EventTransformer<StoreEvent> debounceRestartable<StoreEvent>(
      Duration duration,
      ) {
    // This feeds the debounced event stream to restartable() and returns that
    // as a transformer.
    return (events, mapper) => events.debounceTime(duration);
  }
  EventTransformer<StoreEvent> debounce<StoreEvent>({
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return (events, mapper) => events.debounce((event) => TimerStream(true, duration),).switchMap(mapper);
  }
}
