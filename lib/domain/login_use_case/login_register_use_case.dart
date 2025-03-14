import 'package:firebase_auth/firebase_auth.dart';
import 'package:moviebuddy/data/user_repository/user_repository.dart';

class LoginRegisterUseCase {
  final UserRepository _userRepository;

  LoginRegisterUseCase(this._userRepository);

  Future<UserCredential> execute(String email, String password) async {
    return await _userRepository.login(
      email,
      password,
    );
  }

  Future<UserCredential> reg(String email, String password) async {
    return await _userRepository.register(
      email,
      password,
    );
  }
}
