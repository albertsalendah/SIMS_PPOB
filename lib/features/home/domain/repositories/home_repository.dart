import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/banners.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/menu.dart';

import '../../../../core/errors/failure.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, ResponseApi<List<Banners>>>> getBanner(
      {required String token});
  Future<Either<Failure, ResponseApi<List<Menus>>>> getMenu(
      {required String token});
}
