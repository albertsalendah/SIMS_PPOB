import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/exceptions.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/entities/user.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  ProfileRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, ResponseApi<User>>> getUserProfile(
      {required String token}) async {
    try {
      final res = await remoteDataSource.getUserProfile(token: token);
      return right(
        ResponseApi<User>(
          status: res.status,
          message: res.message,
          data: res.data as User,
        ),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ResponseApi<User>>> updateUserProfile({
    required String firstName,
    required String lastName,
    required String token,
  }) async {
    try {
      final res = await remoteDataSource.upgateUserProfile(
        firstName: firstName,
        lastName: lastName,
        token: token,
      );
      return right(
        ResponseApi<User>(
          status: res.status,
          message: res.message,
          data: res.data as User,
        ),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ResponseApi<User>>> uploadImage(File image,
      {required String token}) async {
    try {
      final res = await remoteDataSource.uploadImage(image, token: token);
      return right(
        ResponseApi<User>(
          status: res.status,
          message: res.message,
          data: User(
            email: res.data.email,
            firstName: res.data.firstName,
            lastName: res.data.lastName,
            imgUrl: res.data.imgUrl,
          ),
        ),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
