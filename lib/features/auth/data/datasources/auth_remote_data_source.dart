import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/exceptions.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/model/response_api_model.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/data/models/auth_token_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<ResponseApiModel<AuthTokenModel>> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  });
  Future<ResponseApiModel<AuthTokenModel>> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio client;
  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<ResponseApiModel<AuthTokenModel>> login(
      {required String email, required String password}) async {
    try {
      var data = json.encode({"email": email, "password": password});
      var response = await client.post('/login', data: data);
      if (response.data != null) {
        final auth = ResponseApiModel<AuthTokenModel>.fromJson(
            response.data, AuthTokenModel.fromJson);
        if (auth.data != null && auth.data!.token != null) {
          return auth;
        } else {
          throw ServerException("Token missing");
        }
      } else {
        throw ServerException("Invalid response");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        try {
          final auth = ResponseApiModel<AuthTokenModel>.fromJson(
              e.response?.data, AuthTokenModel.fromJson);
          return auth;
        } catch (e) {
          throw ServerException("Invalid response data");
        }
      } else {
        throw ServerException(e.message ?? "Network error.");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ResponseApiModel<AuthTokenModel>> signUp(
      {required String email,
      required String firstName,
      required String lastName,
      required String password}) async {
    try {
      var data = json.encode({
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "password": password
      });
      var response = await client.post('/registration', data: data);

      if (response.data != null) {
        final auth = ResponseApiModel<AuthTokenModel>.fromJson(
            response.data, AuthTokenModel.fromJson);
        return auth;
      } else {
        throw ServerException("Invalid response");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        try {
          final auth = ResponseApiModel<AuthTokenModel>.fromJson(
              e.response?.data, AuthTokenModel.fromJson);
          return auth;
        } catch (e) {
          throw ServerException("Invalid response data");
        }
      } else {
        throw ServerException(e.message ?? "Network error.");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
