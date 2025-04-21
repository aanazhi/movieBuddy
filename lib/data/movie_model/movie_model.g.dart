// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      id: json['id'],
      name: json['name'] as String?,
      description: json['description'] as String?,
      year: (json['year'] as num?)?.toInt(),
      poster: json['poster'] == null
          ? null
          : PosterModel.fromJson(json['poster'] as Map<String, dynamic>),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenresModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rating: json['rating'] == null
          ? null
          : RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'year': instance.year,
      'poster': instance.poster,
      'genres': instance.genres,
      'rating': instance.rating,
    };

PosterModel _$PosterModelFromJson(Map<String, dynamic> json) => PosterModel(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$PosterModelToJson(PosterModel instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

GenresModel _$GenresModelFromJson(Map<String, dynamic> json) => GenresModel(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GenresModelToJson(GenresModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => RatingModel(
      kp: (json['kp'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RatingModelToJson(RatingModel instance) =>
    <String, dynamic>{
      'kp': instance.kp,
    };
