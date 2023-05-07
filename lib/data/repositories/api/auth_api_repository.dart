// import 'package:dio/dio.dart';
// import 'package:member_app/data/services/api_client.dart';
// import 'package:member_app/data/services/api_config.dart';
//
// import '../../../business_logic/repositories/auth_repository.dart';
// import '../../../exception/app_exception.dart';
// import '../../../exception/app_message.dart';
// import '../../models/response_model.dart';
//
// class AuthStorageRepository extends AuthRepository {
//   final _dio = ApiClient.dio;
//
//   @override
//   Future<ResponseModel<bool>> login({
//     required String phone,
//   }) async {
//     try {
//       _dio.get(
//         ApiRouter.authLogin,
//         queryParameters: {'phone': phone},
//       );
//       return true;
//     } on DioError catch (ex) {
//       if (ex.error is AppMessage) {
//
//       } else {
//
//       }
//       throw AppException(
//         message: AppMessage(
//           type: AppMessageType.error,
//           title: 'Lỗi mạng!',
//           content: 'Gặp sự cố khi login',
//         ),
//       );
//     }
//     return false;
//   }
//
//   @override
//   Future<bool?> otpCheck({
//     required String phone,
//     required String otp,
//   }) async {
//     try {
//       return true;
//     } on DioError catch (ex) {
//       throw AppException(
//         message: AppMessage(
//           type: AppMessageType.error,
//           title: 'Lỗi mạng!',
//           content: 'Gặp sự cố khi check OTP',
//         ),
//       );
//     }
//     return false;
//   }
//
//   @override
//   Future<bool?> register({
//     required String phone,
//     required String firstName,
//     required String lastName,
//     required int gender,
//     required int dob,
//   }) async {
//     try {
//       return true;
//     } on DioError catch (ex) {
//       throw AppException(
//         message: AppMessage(
//           type: AppMessageType.error,
//           title: 'Lỗi mạng!',
//           content: 'Gặp sự cố khi register',
//         ),
//       );
//     }
//     return false;
//   }
// }
