import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/domain/entities/balance.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/domain/repositories/topup_repository.dart';

class TopupBalance implements UseCase<ResponseApi<Balance>, TopupBalanceParam> {
  final TopUpRepository repository;

  TopupBalance({
    required this.repository,
  });
  @override
  Future<Either<Failure, ResponseApi<Balance>>> call(
      TopupBalanceParam params) async {
    return await repository.topuoBalance(
      nominal: params.nominal,
      token: params.token,
    );
  }
}

class TopupBalanceParam {
  final int nominal;
  final String token;

  TopupBalanceParam({
    required this.nominal,
    required this.token,
  });
}
