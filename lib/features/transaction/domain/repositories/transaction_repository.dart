import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/history.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure, ResponseApi<Transaction>>> servicePayment({
    required String srvcCode,
    required String token,
  });

  Future<Either<Failure, ResponseApi<History>>> getHistory({
    required int offset,
    required int limit,
    required String token,
  });
}
