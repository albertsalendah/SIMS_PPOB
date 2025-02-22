// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/menu.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/repositories/home_repository.dart';

class GetMenu implements UseCase<ResponseApi<List<Menus>>, String> {
  final HomeRepository repository;
  GetMenu({
    required this.repository,
  });
  @override
  Future<Either<Failure, ResponseApi<List<Menus>>>> call(String params) async {
    return await repository.getMenu(token: params);
  }
}
