import 'package:dio/dio.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/exceptions.dart';

import 'package:sims_ppob_richard_albert_salendah/core/shared/model/response_api_model.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/data/models/banner_model.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/data/models/menu_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<ResponseApiModel<List<BannerModel>>> getBanner(
      {required String token});
  Future<ResponseApiModel<List<MenuModel>>> getMenu({required String token});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio client;
  HomeRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<ResponseApiModel<List<BannerModel>>> getBanner(
      {required String token}) async {
    try {
      final response = await client.get('/banner',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      final res = ResponseApiModel<List<BannerModel>>.fromListJson(
        response.data,
        (list) => list
            .map((item) => BannerModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
      if (res.data != null) {
        return res;
      } else {
        throw ServerException("Data missing");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final res = ResponseApiModel<List<BannerModel>>.fromListJson(
          e.response?.data,
          (list) => list
              .map((item) => BannerModel.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
        try {
          if (res.data != null) {
            return res;
          } else {
            throw ServerException("Data missing");
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
  Future<ResponseApiModel<List<MenuModel>>> getMenu(
      {required String token}) async {
    try {
      final response = await client.get('/services',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      final res = ResponseApiModel<List<MenuModel>>.fromListJson(
        response.data,
        (list) => list
            .map((item) => MenuModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
      if (res.data != null) {
        return res;
      } else {
        throw ServerException("Data missing");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final res = ResponseApiModel<List<MenuModel>>.fromListJson(
          e.response?.data,
          (list) => list
              .map((item) => MenuModel.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
        try {
          if (res.data != null) {
            return res;
          } else {
            throw ServerException("Data missing");
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
