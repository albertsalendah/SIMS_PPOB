import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/exceptions.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/data/datasources/transaction_remote_data_source.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/history.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/transaction.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, ResponseApi<Transaction>>> servicePayment({
    required String srvcCode,
    required String token,
  }) async {
    try {
      final res = await remoteDataSource.servicePayment(
          srvcCode: srvcCode, token: token);
      return right(
        ResponseApi<Transaction>(
          status: res.status,
          message: res.message,
          data: res.data as Transaction,
        ),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ResponseApi<History>>> getHistory(
      {required int offset, required int limit, required String token}) async {
    try {
      final res = await remoteDataSource.getTransaction(
          offset: offset, limit: limit, token: token);
      return right(
        ResponseApi<History>(
          status: res.status,
          message: res.message,
          data: res.data as History,
        ),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
