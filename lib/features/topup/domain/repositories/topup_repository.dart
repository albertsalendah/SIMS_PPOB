import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/domain/entities/balance.dart';

abstract interface class TopUpRepository {
  Future<Either<Failure, ResponseApi<Balance>>> getBalance(
      {required String token});
  Future<Either<Failure, ResponseApi<Balance>>> topuoBalance(
      {required int nominal, required String token});
}
