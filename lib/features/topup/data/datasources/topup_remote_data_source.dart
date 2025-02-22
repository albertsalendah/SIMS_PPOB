import 'package:dio/dio.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/exceptions.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/model/response_api_model.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/data/models/balance_model.dart';

abstract interface class TopUpRemoteDataSource {
  Future<ResponseApiModel<BalanceModel>> getBalance({required String token});
  Future<ResponseApiModel<BalanceModel>> topupBalance(
      {required int nominal, required String token});
}

class TopUpRemoteDataSourceImpl implements TopUpRemoteDataSource {
  final Dio client;

  TopUpRemoteDataSourceImpl({required this.client});
  @override
  Future<ResponseApiModel<BalanceModel>> getBalance(
      {required String token}) async {
    try {
      final response = await client.get('/balance',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      final res = ResponseApiModel<BalanceModel>.fromJson(
          response.data, BalanceModel.fromJson);
      if (res.data != null) {
        return res;
      } else {
        throw ServerException("Data missing");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final res = ResponseApiModel<BalanceModel>.fromJson(
            e.response?.data, BalanceModel.fromJson);
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
  Future<ResponseApiModel<BalanceModel>> topupBalance(
      {required int nominal, required String token}) async {
    try {
      final response = await client.post('/topup',
          data: {"top_up_amount": nominal},
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      final res = ResponseApiModel<BalanceModel>.fromJson(
          response.data, BalanceModel.fromJson);
      if (res.data != null) {
        return res;
      } else {
        throw ServerException("Data missing");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final res = ResponseApiModel<BalanceModel>.fromJson(
            e.response?.data, BalanceModel.fromJson);
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
