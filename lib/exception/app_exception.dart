import 'app_message.dart';

class AppException implements Exception {
  final AppMessage message;
  AppException({required this.message});
}