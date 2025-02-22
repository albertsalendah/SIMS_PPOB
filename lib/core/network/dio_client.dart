import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  static final Dio dio = Dio();
  void configureDio() {
    dio.options.baseUrl = dotenv.get('API_URL');
    dio.options.headers = {'Content-Type': 'application/json'};
  }
}
