import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/exceptions.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/data/datasources/topup_remote_data_source.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/domain/entities/balance.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/domain/repositories/topup_repository.dart';

class TopUpRepositoryImpl implements TopUpRepository {
  final TopUpRemoteDataSource remoteDataSource;
  TopUpRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, ResponseApi<Balance>>> getBalance(
      {required String token}) async {
    try {
      final res = await remoteDataSource.getBalance(token: token);
      return right(
        ResponseApi<Balance>(
          status: res.status,
          message: res.message,
          data: res.data as Balance,
        ),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ResponseApi<Balance>>> topuoBalance(
      {required int nominal, required String token}) async {
    try {
      final res =
          await remoteDataSource.topupBalance(nominal: nominal, token: token);
      return right(
        ResponseApi<Balance>(
          status: res.status,
          message: res.message,
          data: res.data as Balance,
        ),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
