import 'package:moviebuddy/data/database_repository/database_repository.dart';
import 'package:moviebuddy/data/user_model/user_model.dart';

class GetUserUseCase {
  final DatabaseRepository _databaseRepository;

  GetUserUseCase(this._databaseRepository);

  Future<UserModel> call(String id) async {
    final userModel = await _databaseRepository.getUser(id);
    return userModel;
  }
}
