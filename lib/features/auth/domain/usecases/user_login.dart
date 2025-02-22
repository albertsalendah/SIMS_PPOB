import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/domain/entities/auth_tokens.dart';
import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/domain/repositories/auth_repository.dart';

class UserLogin implements UseCase<ResponseApi<AuthTokens>, UserLoginParams> {
  final AuthRepository repository;
  const UserLogin(this.repository);
  @override
  Future<Either<Failure, ResponseApi<AuthTokens>>> call(
      UserLoginParams params) async {
    return await repository.login(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
