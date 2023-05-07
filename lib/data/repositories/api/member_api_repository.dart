// import 'package:dio/dio.dart';
//
// import '../../../data/models/app_bar_model.dart';
// import '../../../data/models/card_model.dart';
// import '../../../data/models/history_point_model.dart';
// import '../../../business_logic/repositories/member_repository.dart';
// import '../../../exception/app_exception.dart';
// import '../../../exception/app_message.dart';
//
// class MemberStorageRepository extends MemberRepository {
//   @override
//   Future<AppBarModel?> getAppBar() async {
//     try {
//       return const AppBarModel(
//         greeting: 'Chúc ngủ ngon',
//         cartTemplateAmount: 8,
//         voucherAmount: 4,
//         notifyAmount: 7,
//       );
//     } on DioError catch (ex) {
//       throw AppException(
//         message: AppMessage(
//           type: AppMessageType.error,
//           title: 'Lỗi mạng!',
//           content: 'Gặp sự cố khi lấy App Bar',
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<CardModel?> getCard() async {
//     try {
//       return const CardModel(
//         id: 'CARD-01',
//         code: 'UMT19110475',
//         name: 'Tín Phan',
//         point: 700,
//         currentPoint: 430,
//         currentRankName: 'Vàng',
//         currentRankPoint: 500,
//         backgroundImage: 'https://static.vecteezy.com/system/resources/thumbnails/009/262/854/small/bright-decorative-background-with-mandala-pattern-blank-for-postcard-invitation-banner-with-place-for-text-illustration-vector.jpg',
//         nextRankName: 'Bạch Kim',
//         nextRankPoint: 1000,
//         description: 'Còn 300 BEAN nữa để thăng hạng|Đổi điểm không ảnh hưởng '
//             'đến cấp bậc. Cùng đổi điểm nào!|Sắp đạt mức cuối rồi!',
//         color: 4292467199,
//       );
//     } on DioError catch (ex) {
//       throw AppException(
//         message: AppMessage(
//           type: AppMessageType.error,
//           title: 'Lỗi mạng!',
//           content: 'Gặp sự cố khi lấy Card',
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<MapEntry<int, List<HistoryPointModel>>> getHistoryPoint({
//     int? page,
//     int? limit,
//   }) async {
//     try {
//       return MapEntry(65, List.generate(
//         20,
//             (index) => HistoryPointModel(
//           id: 'HISTORY-$index',
//           point: 96,
//           name:
//           'Đường Đen Marble Latte, Hi-Tea Yuzu Trần Châu +2 sản phẩm khác',
//           time: DateTime.now(),
//         ),
//       ));
//     } on DioError catch (ex) {
//       throw AppException(
//         message: AppMessage(
//           type: AppMessageType.error,
//           title: 'Lỗi mạng!',
//           content: 'Gặp sự cố khi lấy danh sách history point',
//         ),
//       );
//     }
//   }
// }
