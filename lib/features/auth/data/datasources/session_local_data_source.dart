import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionLocalDataSource {
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> clearToken();
  bool isTokenExpired(String token);
}

class SessionLocalDataSourceImpl implements SessionLocalDataSource {
  final SharedPreferences sharedPreferences;

  SessionLocalDataSourceImpl({required this.sharedPreferences});

  static const String _tokenKey = 'auth_token';

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(_tokenKey, token);
  }

  @override
  String? getToken() {
    return sharedPreferences.getString(_tokenKey);
  }

  @override
  Future<void> clearToken() async {
    await sharedPreferences.remove(_tokenKey);
  }

  @override
  bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }
}
