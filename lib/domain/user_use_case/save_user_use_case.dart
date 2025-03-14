import 'package:moviebuddy/data/database_repository/database_repository.dart';
import 'package:moviebuddy/data/user_model/user_model.dart';
import 'package:moviebuddy/domain/user_entity/user_entity.dart';

class SaveUserUseCase {
  final DatabaseRepository _databaseRepository;

  SaveUserUseCase(this._databaseRepository);

  Future<void> call(UserEntity user) async {
    final userModel = UserModel(
      id: user.id,
      email: user.email,
      nickname: user.nickname,
      moviesCollection: [],
    );
    await _databaseRepository.saveUser(userModel);
  }
}
