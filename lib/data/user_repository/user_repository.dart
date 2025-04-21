import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:moviebuddy/data/user_local_data_source/user_token_local_data_source.dart';
import 'package:moviebuddy/data/user_model/user_model.dart';
import 'package:moviebuddy/data/user_remote_data_source/user_remote_data_source.dart';

abstract class UserRepository {
  Future<UserCredential> login(String email, String password);
  Future<UserModel> getCurrentUser();
  Future<UserCredential> register(String email, String password);
  Future<void> saveToken(String? uid);
  Future<bool> autoLogin();
}

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth;
  final UserTokenLocalDataSource _userTokenLocalDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl({
    required FirebaseAuth auth,
    required UserTokenLocalDataSource userTokenLocalDataSource,
    required UserRemoteDataSource userRemoteDataSource,
  })  : _auth = auth,
        _userTokenLocalDataSource = userTokenLocalDataSource,
        _userRemoteDataSource = userRemoteDataSource;

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
  Future<UserModel> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("Пользователь не авторизован");
    }
    try {
      final userData = await _userRemoteDataSource.getUser(user.uid);
      return userData;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting user data from remote source: $e');
      }
      throw Exception('Failed to load user data: $e');
    }
  }

  @override
  Future<UserCredential> register(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        id: credential.user!.uid,
        email: email,
        nickname: email,
        photo: 'assets/images/black.png',
        moviesCollection: [],
      );
      await _userRemoteDataSource.saveUser(user);

      await saveToken(credential.user!.uid);
      return credential;
    } catch (e) {
      print('Error during registration: $e');
      throw e;
    }
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
