import 'package:firebase_auth/firebase_auth.dart';
import 'package:moviebuddy/data/user_local_data_source/user_token_local_data_source.dart';

abstract class UserRepository {
  Future<UserCredential> login(String email, String password);
  Future<UserCredential> register(String email, String password);
  Future<void> saveToken(String? uid);
  Future<bool> autoLogin();
}

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth;
  final UserTokenLocalDataSource _userTokenLocalDataSource;

  UserRepositoryImpl(
      {required FirebaseAuth auth,
      required UserTokenLocalDataSource userTokenLocalDataSource})
      : _auth = auth,
        _userTokenLocalDataSource = userTokenLocalDataSource;

  @override
  Future<UserCredential> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await saveToken(credential.user!.uid);
    return credential;
  }

  @override
  Future<UserCredential> register(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await saveToken(credential.user!.uid);
    return credential;
  }

  @override
  Future<void> saveToken(String? uid) async {
    if (uid != null) {
      await _userTokenLocalDataSource.saveUserToken(uid);
    }
  }

  @override
  Future<bool> autoLogin() async {
    final token = await _userTokenLocalDataSource.getUserToken();
    if (token != null) {
      try {
        await _auth.signInWithCustomToken(token);
        return true;
      } catch (error) {
        await _userTokenLocalDataSource.saveUserToken('');
        return false;
      }
    }
    return false;
  }
}
