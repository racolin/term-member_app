import 'package:dio/dio.dart';
import '../services/api_client.dart';

class AuthProvider {
  final Dio dio = ApiClient.notAuthDio;


}