import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/entities/user.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, ResponseApi<User>>> getUserProfile(
      {required String token});
  Future<Either<Failure, ResponseApi<User>>> uploadImage(File image,
      {required String token});
  Future<Either<Failure, ResponseApi<User>>> updateUserProfile(
      {required String firstName,
      required String lastName,
      required String token});
}
