import 'package:moviebuddy/data/user_model/user_model.dart';

class UserEntity {
  final String id;
  final String email;
  final String nickname;
  final List<MovieCollection> movieCollections;

  UserEntity({
    required this.id,
    required this.email,
    required this.nickname,
    required this.movieCollections,
  });
}
