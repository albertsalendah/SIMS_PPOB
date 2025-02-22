import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/domain/entities/auth_tokens.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

// Example of use case
class UserSignUp implements UseCase<ResponseApi<AuthTokens>, UserSignUpParams> {
  final AuthRepository repository;
  const UserSignUp(this.repository);

  @override
  Future<Either<Failure, ResponseApi<AuthTokens>>> call(
      UserSignUpParams params) async {
    return await repository.signUp(
      email: params.email,
      firstName: params.firstName,
      lastName: params.lastName,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  UserSignUpParams({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });
}
