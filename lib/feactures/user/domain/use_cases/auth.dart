
import '../../data/models/models_user.dart';
import '../repository/user_repository.dart';
import '../request/request_user.dart';

class AuthUseCase {
  final UserRepository repository;

  AuthUseCase({required this.repository});

  Future<DataAuth> call({required AuthRequest request}) {
    return repository.auth(request: request);
  }
}
