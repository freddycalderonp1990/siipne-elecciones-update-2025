
import '../repository/user_repository.dart';
import '../request/request_user.dart';

class AuthUseCase {
  final UserRepository repository;

  AuthUseCase({required this.repository});

  Future<String> call({required AuthRequest request}) {
    return repository.auth(request: request);
  }
}
