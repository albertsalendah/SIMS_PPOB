import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/domain/repositories/auth_repository.dart';

class UserSession implements SessionUseCase<bool, NoParams> {
  AuthRepository repository;
  UserSession(this.repository);
  @override
  bool call(NoParams params) {
    return repository.isLoggedIn();
  }

  String? getToken() {
    return repository.getToken();
  }

  bool isTokenExpired(String token) {
    return repository.isTokenExpired(token: token);
  }
}
