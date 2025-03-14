// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      moviesCollection: (json['moviesCollection'] as List<dynamic>?)
          ?.map((e) => MovieCollection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'moviesCollection': instance.moviesCollection,
    };

MovieCollection _$MovieCollectionFromJson(Map<String, dynamic> json) =>
    MovieCollection(
      name: json['name'] as String,
      movies: (json['movies'] as List<dynamic>?)
          ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieCollectionToJson(MovieCollection instance) =>
    <String, dynamic>{
      'name': instance.name,
      'movies': instance.movies,
    };
