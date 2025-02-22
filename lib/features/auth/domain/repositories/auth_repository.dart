import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/domain/entities/auth_tokens.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, ResponseApi<AuthTokens>>> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  });
  Future<Either<Failure, ResponseApi<AuthTokens>>> login({
    required String email,
    required String password,
  });

  Future<void> logout();
  bool isLoggedIn();
  bool isTokenExpired({required String token});
  String? getToken();
}
