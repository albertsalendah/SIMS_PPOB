// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:fpdart/src/either.dart';

import 'package:sims_ppob_richard_albert_salendah/core/errors/failure.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/entities/user.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/repositories/profile_repository.dart';

class UploadImage implements UseCase<ResponseApi<User>, UploadImageParams> {
  final ProfileRepository repository;
  UploadImage({
    required this.repository,
  });
  @override
  Future<Either<Failure, ResponseApi<User>>> call(
      UploadImageParams params) async {
    return await repository.uploadImage(params.image, token: params.token);
  }
}

class UploadImageParams {
  final File image;
  final String token;
  UploadImageParams({
    required this.image,
    required this.token,
  });
}
