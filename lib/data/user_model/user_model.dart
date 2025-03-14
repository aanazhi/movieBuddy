import 'package:json_annotation/json_annotation.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String nickname;
  final List<MovieCollection>? moviesCollection;

  UserModel({
    required this.id,
    required this.email,
    required this.nickname,
    this.moviesCollection,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class MovieCollection {
  final String name;
  List<MovieModel>? movies;

  MovieCollection({
    required this.name,
    this.movies,
  });

  factory MovieCollection.fromJson(Map<String, dynamic> json) {
    final movieCollection = _$MovieCollectionFromJson(json);
    return movieCollection;
  }

  Map<String, dynamic> toJson() => _$MovieCollectionToJson(this);
}
