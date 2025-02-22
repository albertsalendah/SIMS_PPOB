import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/entities/user.dart';
import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/repositories/profile_repository.dart';

class GetUserProfile implements UseCase<ResponseApi<User>, String> {
  final ProfileRepository repository;
  GetUserProfile({required this.repository});
  @override
  Future<Either<Failure, ResponseApi<User>>> call(String params) async {
    return await repository.getUserProfile(token: params);
  }
}
