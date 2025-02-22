// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/history.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/repositories/transaction_repository.dart';

class GetTransaction implements UseCase<ResponseApi<History>, HistoryParam> {
  final TransactionRepository repository;

  GetTransaction({required this.repository});

  @override
  Future<Either<Failure, ResponseApi<History>>> call(
      HistoryParam params) async {
    return await repository.getHistory(
      token: params.token,
      offset: params.offset,
      limit: params.limit,
    );
  }
}

class HistoryParam {
  final int offset;
  final int limit;
  final String token;
  HistoryParam({
    required this.offset,
    required this.limit,
    required this.token,
  });
}
