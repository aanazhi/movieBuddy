// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      photo: json['photo'] as String?,
      moviesCollection: (json['moviesCollection'] as List<dynamic>?)
          ?.map((e) => MovieCollection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'photo': instance.photo,
      'moviesCollection': instance.moviesCollection,
    };

MovieCollection _$MovieCollectionFromJson(Map<String, dynamic> json) =>
    MovieCollection(
      id: json['id'] as String,
      name: json['name'] as String,
      movies: (json['movies'] as List<dynamic>?)
          ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieCollectionToJson(MovieCollection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'movies': instance.movies,
    };
