import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/entities/user.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/usecases/get_user_profile.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/usecases/update_user_profile.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/usecases/upload_image.dart';

enum ProfileStatus {
  initial,
  loading,
  getSuccess,
  updateSuccess,
  imageSuccess,
  error
}

class ProfileProvider with ChangeNotifier {
  final GetUserProfile getUserProfile;
  final UpdateUserProfile updateUserProfile;
  final UploadImage uploadImage;
  ProfileProvider({
    required this.getUserProfile,
    required this.updateUserProfile,
    required this.uploadImage,
  });

  ProfileStatus _status = ProfileStatus.initial;
  String? _message;
  User? _user;

  ProfileStatus get status => _status;
  String? get message => _message;
  User? get user => _user;

  Future<void> getUser({required String token}) async {
    _setStatus(ProfileStatus.loading);
    final result = await getUserProfile(token);
    result.fold((failure) {
      _setStatus(ProfileStatus.error, message: failure.message);
    }, (success) {
      _user = success.data;
      _setStatus(ProfileStatus.getSuccess, message: success.message);
    });
  }

  Future<void> updateUser({
    required String firstName,
    required String lastName,
    required String token,
  }) async {
    _setStatus(ProfileStatus.loading);
    final result = await updateUserProfile(UpdateUserParams(
      firstName: firstName,
      lastName: lastName,
      token: token,
    ));
    result.fold((failure) {
      _setStatus(ProfileStatus.error, message: failure.message);
    }, (success) {
      _user = success.data;
      _setStatus(ProfileStatus.updateSuccess, message: success.message);
    });
  }

  Future<void> uploadImages(
    File image, {
    required String token,
  }) async {
    _setStatus(ProfileStatus.loading);
    final result =
        await uploadImage(UploadImageParams(image: image, token: token));
    result.fold((failure) {
      _setStatus(ProfileStatus.error, message: failure.message);
    }, (success) {
      _user = success.data;
      _setStatus(ProfileStatus.updateSuccess, message: success.message);
    });
  }

  void _setStatus(ProfileStatus status, {String? message}) {
    _status = status;
    _message = message;
    notifyListeners();
  }

  void resetState() {
    _setStatus(ProfileStatus.initial);
  }
}
