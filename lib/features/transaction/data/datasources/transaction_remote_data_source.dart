import 'package:dio/dio.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/exceptions.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/model/response_api_model.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/data/models/history_model.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/data/models/transaction_model.dart';

abstract interface class TransactionRemoteDataSource {
  Future<ResponseApiModel<TransactionModel>> servicePayment({
    required String srvcCode,
    required String token,
  });
  Future<ResponseApiModel<HistoryModel>> getTransaction(
      {required int offset, required int limit, required String token});
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Dio client;

  TransactionRemoteDataSourceImpl({required this.client});

  @override
  Future<ResponseApiModel<TransactionModel>> servicePayment(
      {required String srvcCode, required String token}) async {
    try {
      final response = await client.post('/transaction',
          data: {"service_code": srvcCode},
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      final res = ResponseApiModel<TransactionModel>.fromJson(
          response.data, TransactionModel.fromJson);
      if (res.data != null) {
        return res;
      } else {
        throw ServerException("Data missing");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final res = ResponseApiModel<TransactionModel>.fromJson(
            e.response?.data, TransactionModel.fromJson);
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
  Future<ResponseApiModel<HistoryModel>> getTransaction(
      {required int offset, required int limit, required String token}) async {
    try {
      final response =
          await client.get('/transaction/history?offset=$offset&limit=$limit',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'application/json',
                },
              ));
      final res = ResponseApiModel<HistoryModel>.fromJson(
          response.data, HistoryModel.fromJson);
      if (res.data != null) {
        return res;
      } else {
        throw ServerException("Data missing");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final res = ResponseApiModel<HistoryModel>.fromJson(
            e.response?.data, HistoryModel.fromJson);
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
