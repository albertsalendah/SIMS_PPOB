import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/banners.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/repositories/home_repository.dart';

class GetBanner implements UseCase<ResponseApi<List<Banners>>, String> {
  final HomeRepository repository;
  GetBanner({
    required this.repository,
  });
  @override
  Future<Either<Failure, ResponseApi<List<Banners>>>> call(
      String params) async {
    return await repository.getBanner(token: params);
  }
}
