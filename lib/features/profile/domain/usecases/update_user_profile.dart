import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/entities/user.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserProfile
    implements UseCase<ResponseApi<User>, UpdateUserParams> {
  final ProfileRepository repository;
  UpdateUserProfile({required this.repository});
  @override
  Future<Either<Failure, ResponseApi<User>>> call(
      UpdateUserParams params) async {
    return await repository.updateUserProfile(
      firstName: params.firstName,
      lastName: params.lastName,
      token: params.token,
    );
  }
}

class UpdateUserParams {
  final String firstName;
  final String lastName;
  final String token;

  UpdateUserParams({
    required this.firstName,
    required this.lastName,
    required this.token,
  });
}
