import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/exceptions.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/data/datasources/session_local_data_source.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/domain/entities/auth_tokens.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SessionLocalDataSource localDataSource;
  const AuthRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, ResponseApi<AuthTokens>>> login(
      {required String email, required String password}) async {
    try {
      final res =
          await remoteDataSource.login(email: email, password: password);

      if (res.status == 0 && res.data?.token != null) {
        await localDataSource.saveToken(res.data!.token!);
        return right(ResponseApi<AuthTokens>(
            data: res.data, status: res.status, message: res.message));
      } else {
        return left(Failure(res.message));
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ResponseApi<AuthTokens>>> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    try {
      final res = await remoteDataSource.signUp(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
      );

      return right(
        ResponseApi<AuthTokens>(
            data: res.data, status: res.status, message: res.message),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  bool isLoggedIn() {
    final token = localDataSource.getToken();
    return token != null && !localDataSource.isTokenExpired(token);
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearToken();
  }

  @override
  String? getToken() {
    return localDataSource.getToken();
  }

  @override
  bool isTokenExpired({required String token}) {
    return localDataSource.isTokenExpired(token);
  }
}
