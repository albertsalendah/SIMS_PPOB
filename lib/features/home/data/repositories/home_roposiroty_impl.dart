import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/exceptions.dart';

import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/data/datasources/home_remote_data_source.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/banners.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/menu.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  HomeRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, ResponseApi<List<Banners>>>> getBanner(
      {required String token}) async {
    try {
      final res = await remoteDataSource.getBanner(token: token);
      return right(
        ResponseApi<List<Banners>>(
          status: res.status,
          message: res.message,
          data: res.data as List<Banners>,
        ),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ResponseApi<List<Menus>>>> getMenu(
      {required String token}) async {
    try {
      final res = await remoteDataSource.getMenu(token: token);
      return right(
        ResponseApi<List<Menus>>(
          status: res.status,
          message: res.message,
          data: res.data as List<Menus>,
        ),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
