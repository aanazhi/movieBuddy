import 'package:firebase_auth/firebase_auth.dart';
import 'package:moviebuddy/data/user_repository/user_repository.dart';

abstract class LoginRegisterUseCase {
  Future<UserCredential> execute(String email, String password);
  Future<UserCredential> reg(String email, String password);
}

class LoginRegisterUseCaseImpl implements LoginRegisterUseCase {
  final UserRepository _userRepository;

  LoginRegisterUseCaseImpl(this._userRepository);

  @override
  Future<UserCredential> execute(String email, String password) async {
    return await _userRepository.login(
      email,
      password,
    );
  }

  @override
  Future<UserCredential> reg(String email, String password) async {
    return await _userRepository.register(
      email,
      password,
    );
  }
}
