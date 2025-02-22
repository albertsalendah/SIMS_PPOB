import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/domain/repositories/auth_repository.dart';

class UserLogout implements SessionUseCase<void, NoParams> {
  final AuthRepository repository;
  const UserLogout(this.repository);

  @override
  Future<void> call(NoParams params) async {
    await repository.logout();
  }
}
