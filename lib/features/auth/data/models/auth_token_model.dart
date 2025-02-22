import 'package:sims_ppob_richard_albert_salendah/features/auth/domain/entities/auth_tokens.dart';

class AuthTokenModel extends AuthTokens {
  AuthTokenModel({super.token});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'token': token,
    };
  }

  AuthTokenModel copyWith({
    String? token,
  }) {
    return AuthTokenModel(
      token: token ?? this.token,
    );
  }
}
