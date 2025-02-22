import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/domain/entities/balance.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/domain/repositories/topup_repository.dart';

class GetBalance implements UseCase<ResponseApi<Balance>, String> {
  final TopUpRepository repository;

  GetBalance({required this.repository});
  @override
  Future<Either<Failure, ResponseApi<Balance>>> call(String params) async {
    return await repository.getBalance(token: params);
  }
}
