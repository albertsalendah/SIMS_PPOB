import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/transaction.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/repositories/transaction_repository.dart';

class ServicePayment
    implements UseCase<ResponseApi<Transaction>, ServicePaymentParams> {
  final TransactionRepository repository;

  ServicePayment({required this.repository});

  @override
  Future<Either<Failure, ResponseApi<Transaction>>> call(
      ServicePaymentParams params) async {
    return await repository.servicePayment(
      srvcCode: params.srvcCode,
      token: params.token,
    );
  }
}

class ServicePaymentParams {
  final String srvcCode;
  final String token;

  ServicePaymentParams({
    required this.srvcCode,
    required this.token,
  });
}
