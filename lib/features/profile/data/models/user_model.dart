import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.imgUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      imgUrl: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'profile_image': imgUrl,
    };
  }

  UserModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? imgUrl,
  }) {
    return UserModel(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }
}
