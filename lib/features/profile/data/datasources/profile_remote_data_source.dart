import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/exceptions.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/model/response_api_model.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/data/models/user_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ResponseApiModel<UserModel>> getUserProfile({required String token});
  Future<ResponseApiModel<UserModel>> uploadImage(File image,
      {required String token});
  Future<ResponseApiModel<UserModel>> upgateUserProfile(
      {required String firstName,
      required String lastName,
      required String token});
}

class ProfileRemotedataSourceImpl implements ProfileRemoteDataSource {
  final Dio client;
  ProfileRemotedataSourceImpl({required this.client});

  // final testRes = ResponseApiModel<UserModel>(
  //       status: 0,
  //       message: 'TEST',
  //       data: UserModel(
  //           email: "Email",
  //           firstName: 'Name',
  //           lastName: 'LastName',
  //           imgUrl: 'null'));

  @override
  Future<ResponseApiModel<UserModel>> getUserProfile(
      {required String token}) async {
    try {
      final response = await client.get('/profile',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));

      final res = ResponseApiModel<UserModel>.fromJson(
          response.data, UserModel.fromJson);

      // if (res.data != null) {
      //   return res.data!;
      // } else {
      //   throw ServerException("User Data missing");
      // }
      if (res.data != null) {
        return res;
      } else {
        throw ServerException("User Data missing");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final res = ResponseApiModel<UserModel>.fromJson(
            e.response?.data, UserModel.fromJson);
        try {
          if (res.data != null) {
            return res;
          } else {
            throw ServerException("User Data missing");
          }
        } catch (e) {
          throw ServerException(res.message);
        }
      } else {
        throw ServerException(e.message ?? "Network error.");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ResponseApiModel<UserModel>> upgateUserProfile({
    required String firstName,
    required String lastName,
    required String token,
  }) async {
    try {
      var data = json.encode({"first_name": firstName, "last_name": lastName});
      final response = await client.put('/profile/update',
          data: data,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));

      final res = ResponseApiModel<UserModel>.fromJson(
          response.data, UserModel.fromJson);
      if (res.data != null) {
        return res;
      } else {
        throw ServerException("User Data missing");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final res = ResponseApiModel<UserModel>.fromJson(
            e.response?.data, UserModel.fromJson);
        try {
          if (res.data != null) {
            return res;
          } else {
            throw ServerException("User Data missing");
          }
        } catch (e) {
          throw ServerException(res.message);
        }
      } else {
        throw ServerException(e.message ?? "Network error.");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ResponseApiModel<UserModel>> uploadImage(File image,
      {required String token}) async {
    try {
      final bytes = await image.readAsBytes();
      String fileName = basename(image.path);

      final formData = FormData.fromMap({
        'file': [
          MultipartFile.fromBytes(bytes,
              filename: fileName, contentType: DioMediaType.parse("image/png")),
        ]
      });

      final response = await client.put('/profile/image',
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          }));
      final res = ResponseApiModel<UserModel>.fromJson(
          response.data, UserModel.fromJson);
      if (res.data != null) {
        return res;
      } else {
        throw ServerException("User Data missing");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final res = ResponseApiModel<UserModel>.fromJson(
            e.response?.data, UserModel.fromJson);
        try {
          if (res.data != null) {
            return res;
          } else {
            throw ServerException("User Data missing");
          }
        } catch (e) {
          throw ServerException(res.message);
        }
      } else {
        throw ServerException(e.message ?? "Network error.");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
